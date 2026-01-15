# Kubernetes 101 Lab - Deployment Script
# This script builds the Docker image and deploys the application to Minikube

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Kubernetes 101 Lab - Deployment" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Check if Minikube is running
Write-Host "Checking Minikube status..." -ForegroundColor Yellow
$minikubeStatus = minikube status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Minikube is not running. Please start Minikube first." -ForegroundColor Red
    Write-Host "Run: minikube start" -ForegroundColor Yellow
    exit 1
}
Write-Host "Minikube is running!" -ForegroundColor Green
Write-Host ""

# Configure Docker to use Minikube's Docker daemon
Write-Host "Configuring Docker environment for Minikube..." -ForegroundColor Yellow
& minikube -p minikube docker-env --shell powershell | Invoke-Expression
Write-Host "Docker environment configured!" -ForegroundColor Green
Write-Host ""

# Build Docker image
Write-Host "Building Docker image..." -ForegroundColor Yellow
Set-Location app
docker build -t flask-k8s-app:latest .
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to build Docker image" -ForegroundColor Red
    exit 1
}
Set-Location ..
Write-Host "Docker image built successfully!" -ForegroundColor Green
Write-Host ""

# Apply Kubernetes manifests
Write-Host "Applying Kubernetes manifests..." -ForegroundColor Yellow

Write-Host "  Creating namespace..." -ForegroundColor Cyan
kubectl apply -f k8s-manifests/01-namespace.yaml

Write-Host "  Creating ConfigMap..." -ForegroundColor Cyan
kubectl apply -f k8s-manifests/02-configmap.yaml

Write-Host "  Creating Secret..." -ForegroundColor Cyan
kubectl apply -f k8s-manifests/03-secret.yaml

Write-Host "  Deploying PostgreSQL..." -ForegroundColor Cyan
kubectl apply -f k8s-manifests/04-postgres-deployment.yaml
kubectl apply -f k8s-manifests/05-postgres-service.yaml

Write-Host "  Deploying Flask application..." -ForegroundColor Cyan
kubectl apply -f k8s-manifests/06-app-deployment.yaml
kubectl apply -f k8s-manifests/07-app-service.yaml

Write-Host ""
Write-Host "All resources deployed successfully!" -ForegroundColor Green
Write-Host ""

# Wait for pods to be ready
Write-Host "Waiting for pods to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=postgres -n k8s-lab --timeout=120s
kubectl wait --for=condition=ready pod -l app=flask-app -n k8s-lab --timeout=120s

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Deployment Complete!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "View resources:" -ForegroundColor Yellow
Write-Host "  kubectl get all -n k8s-lab" -ForegroundColor White
Write-Host ""
Write-Host "Access the application:" -ForegroundColor Yellow
Write-Host "  minikube service flask-app-service -n k8s-lab" -ForegroundColor White
Write-Host ""
