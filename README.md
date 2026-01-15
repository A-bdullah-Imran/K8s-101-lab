# Kubernetes 101 Lab - Minikube Practical

Welcome to the Kubernetes 101 hands-on lab! This practical exercise will help you understand core Kubernetes concepts by deploying a simple two-tier application on Minikube.

## What You'll Learn

- Understanding Pods, Deployments, and Services
- Working with ConfigMaps and Secrets
- Managing Namespaces
- Exploring Kubernetes resources
- Scaling applications
- Troubleshooting pods

## Application Architecture

This lab deploys a simple message application with:
- **Flask Application Pod**: A Python web API for managing messages
- **PostgreSQL Database Pod**: A database for storing messages

## Quick Start

### Prerequisites

- Minikube installed and running
- kubectl installed
- Docker installed

### Deployment Steps

**For Windows (PowerShell):**
```powershell
# Start Minikube (if not already running)
minikube start

# Deploy the application
.\deploy.ps1
```

**For Linux/Mac (Bash):**
```bash
# Start Minikube (if not already running)
minikube start

# Deploy the application
chmod +x deploy.sh
./deploy.sh
```

### Access the Application

```bash
# Get the service URL
minikube service flask-app-service -n k8s-lab
```

### Cleanup

**Windows:**
```cmd
cleanup.bat
```

**Linux/Mac:**
```bash
./cleanup.sh
```

## Lab Guide

For detailed exercises and learning activities, please refer to:
- **LAB_GUIDE.md** - Complete step-by-step lab instructions
- **INSTRUCTOR_GUIDE.md** - Teaching notes and answer key

## Project Structure

```
kubernetes-101-lab/
├── app/
│   ├── app.py              # Flask application
│   ├── requirements.txt    # Python dependencies
│   └── Dockerfile          # Docker image configuration
├── k8s-manifests/
│   ├── 01-namespace.yaml   # Namespace definition
│   ├── 02-configmap.yaml   # Configuration data
│   ├── 03-secret.yaml      # Sensitive data
│   ├── 04-postgres-deployment.yaml
│   ├── 05-postgres-service.yaml
│   ├── 06-app-deployment.yaml
│   └── 07-app-service.yaml
├── deploy.ps1              # Windows deployment script
├── deploy.sh               # Linux/Mac deployment script
├── cleanup.ps1             # Windows cleanup script
├── cleanup.sh              # Linux/Mac cleanup script
├── README.md               # This file
├── LAB_GUIDE.md            # Student lab instructions
└── INSTRUCTOR_GUIDE.md     # Teaching guide
```

## Support

If you encounter issues:
1. Check Minikube is running: `minikube status`
2. Verify kubectl can connect: `kubectl cluster-info`
3. Check pod logs: `kubectl logs <pod-name> -n k8s-lab`

Happy Learning! 🚀
