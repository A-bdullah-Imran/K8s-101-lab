#!/bin/bash

# Kubernetes 101 Lab - Cleanup Script
# This script removes all deployed resources

echo "====================================="
echo "Kubernetes 101 Lab - Cleanup"
echo "====================================="
echo ""

echo "Deleting all resources in k8s-lab namespace..."
kubectl delete namespace k8s-lab

echo ""
echo "Cleanup complete!"
echo ""
