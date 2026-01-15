# Kubernetes 101 Lab - Cleanup Script
# This script removes all deployed resources

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Kubernetes 101 Lab - Cleanup" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Deleting all resources in k8s-lab namespace..." -ForegroundColor Yellow
kubectl delete namespace k8s-lab

Write-Host ""
Write-Host "Cleanup complete!" -ForegroundColor Green
Write-Host ""
