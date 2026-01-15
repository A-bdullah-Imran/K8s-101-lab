from flask import Flask, jsonify, request
import psycopg2
import os
import time

app = Flask(__name__)

# Database configuration from environment variables
DB_HOST = os.getenv('DB_HOST', 'localhost')
DB_PORT = os.getenv('DB_PORT', '5432')
DB_NAME = os.getenv('DB_NAME', 'appdb')
DB_USER = os.getenv('DB_USER', 'postgres')
DB_PASSWORD = os.getenv('DB_PASSWORD', 'password')

def get_db_connection():
    """Create database connection with retry logic"""
    max_retries = 5
    retry_delay = 2
    
    for attempt in range(max_retries):
        try:
            conn = psycopg2.connect(
                host=DB_HOST,
                port=DB_PORT,
                database=DB_NAME,
                user=DB_USER,
                password=DB_PASSWORD
            )
            return conn
        except psycopg2.OperationalError as e:
            if attempt < max_retries - 1:
                print(f"Database connection failed. Retrying in {retry_delay} seconds... (Attempt {attempt + 1}/{max_retries})")
                time.sleep(retry_delay)
            else:
                raise e

def init_db():
    """Initialize database table"""
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('''
            CREATE TABLE IF NOT EXISTS messages (
                id SERIAL PRIMARY KEY,
                message TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        conn.commit()
        cur.close()
        conn.close()
        print("Database initialized successfully!")
    except Exception as e:
        print(f"Error initializing database: {e}")

@app.route('/')
def home():
    """Home endpoint"""
    return jsonify({
        "message": "Welcome to Kubernetes 101 Lab!",
        "endpoints": {
            "/": "Home",
            "/health": "Health check",
            "/messages": "GET - List all messages, POST - Add a message",
            "/messages/<id>": "GET - Get specific message"
        }
    })

@app.route('/health')
def health():
    """Health check endpoint"""
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT 1')
        cur.close()
        conn.close()
        return jsonify({"status": "healthy", "database": "connected"}), 200
    except Exception as e:
        return jsonify({"status": "unhealthy", "database": "disconnected", "error": str(e)}), 500

@app.route('/messages', methods=['GET', 'POST'])
def messages():
    """Get all messages or create a new message"""
    if request.method == 'GET':
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('SELECT id, message, created_at FROM messages ORDER BY created_at DESC')
            rows = cur.fetchall()
            cur.close()
            conn.close()
            
            messages_list = [
                {"id": row[0], "message": row[1], "created_at": str(row[2])}
                for row in rows
            ]
            return jsonify({"messages": messages_list, "count": len(messages_list)}), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
    
    elif request.method == 'POST':
        try:
            data = request.get_json()
            message = data.get('message')
            
            if not message:
                return jsonify({"error": "Message is required"}), 400
            
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('INSERT INTO messages (message) VALUES (%s) RETURNING id', (message,))
            message_id = cur.fetchone()[0]
            conn.commit()
            cur.close()
            conn.close()
            
            return jsonify({"id": message_id, "message": message, "status": "created"}), 201
        except Exception as e:
            return jsonify({"error": str(e)}), 500

@app.route('/messages/<int:message_id>', methods=['GET'])
def get_message(message_id):
    """Get a specific message by ID"""
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT id, message, created_at FROM messages WHERE id = %s', (message_id,))
        row = cur.fetchone()
        cur.close()
        conn.close()
        
        if row:
            return jsonify({"id": row[0], "message": row[1], "created_at": str(row[2])}), 200
        else:
            return jsonify({"error": "Message not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    # Initialize database on startup
    time.sleep(3)  # Wait for database to be ready
    init_db()
    
    # Run the Flask app
    app.run(host='0.0.0.0', port=5000, debug=True)
