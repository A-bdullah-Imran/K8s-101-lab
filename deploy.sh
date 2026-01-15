#!/bin/bash

# Kubernetes 101 Lab - Deployment Script
# This script builds the Docker image and deploys the application to Minikube

echo "====================================="
echo "Kubernetes 101 Lab - Deployment"
echo "====================================="
echo ""

# Check if Minikube is running
echo "Checking Minikube status..."
if ! minikube status &> /dev/null; then
    echo "Error: Minikube is not running. Please start Minikube first."
    echo "Run: minikube start"
    exit 1
fi
echo "Minikube is running!"
echo ""

# Configure Docker to use Minikube's Docker daemon
echo "Configuring Docker environment for Minikube..."
eval $(minikube docker-env)
echo "Docker environment configured!"
echo ""

# Build Docker image
echo "Building Docker image..."
cd app
docker build -t flask-k8s-app:latest .
if [ $? -ne 0 ]; then
    echo "Error: Failed to build Docker image"
    exit 1
fi
cd ..
echo "Docker image built successfully!"
echo ""

# Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."

echo "  Creating namespace..."
kubectl apply -f k8s-manifests/01-namespace.yaml

echo "  Creating ConfigMap..."
kubectl apply -f k8s-manifests/02-configmap.yaml

echo "  Creating Secret..."
kubectl apply -f k8s-manifests/03-secret.yaml

echo "  Deploying PostgreSQL..."
kubectl apply -f k8s-manifests/04-postgres-deployment.yaml
kubectl apply -f k8s-manifests/05-postgres-service.yaml

echo "  Deploying Flask application..."
kubectl apply -f k8s-manifests/06-app-deployment.yaml
kubectl apply -f k8s-manifests/07-app-service.yaml

echo ""
echo "All resources deployed successfully!"
echo ""

# Wait for pods to be ready
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=postgres -n k8s-lab --timeout=120s
kubectl wait --for=condition=ready pod -l app=flask-app -n k8s-lab --timeout=120s

echo ""
echo "====================================="
echo "Deployment Complete!"
echo "====================================="
echo ""
echo "View resources:"
echo "  kubectl get all -n k8s-lab"
echo ""
echo "Access the application:"
echo "  minikube service flask-app-service -n k8s-lab"
echo ""
