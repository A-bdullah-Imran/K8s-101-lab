---
title: Kubernetes 101 - Hands-On Lab Manual
subtitle: Interactive Minikube Practical
author: Instructor Guide
date: 2026
---

# Kubernetes 101 - Hands-On Lab Manual

## Student Information

**Name:** ________________________________

**Date:** ________________________________

**Lab Duration:** 60-90 minutes

---

## Table of Contents

1. Introduction
2. Lab Setup
3. Application Deployment
4. Exploring Namespaces
5. Working with Pods
6. Understanding Services
7. Managing Deployments
8. ConfigMaps and Secrets
9. Testing the Application
10. Resource Exploration
11. Troubleshooting Practice
12. Cleanup
13. Bonus Challenges
14. Lab Summary
15. Reflection

---

## 1. Introduction

### Welcome!

Welcome to your first Kubernetes practical lab! Today, you'll deploy a real application on Kubernetes and learn core concepts through hands-on exercises.

### What You'll Build

A two-tier message application:
- **Flask Web API** (Python)
- **PostgreSQL Database**

### Learning Objectives

After this lab, you will:
- ✅ Deploy applications to Kubernetes
- ✅ Work with Pods, Deployments, and Services
- ✅ Use ConfigMaps and Secrets
- ✅ Manage Namespaces
- ✅ Scale applications
- ✅ Troubleshoot issues
- ✅ View logs and describe resources

---

## 2. Lab Setup

### Step 1: Verify Prerequisites

Check your environment:

```bash
minikube version
kubectl version --client
docker --version
```

**✓ All commands worked?** □ Yes □ No

### Step 2: Start Minikube

```bash
minikube start
minikube status
```

**✓ Minikube running?** □ Yes □ No

### Step 3: Verify Connection

```bash
kubectl cluster-info
```

**✓ Can connect to cluster?** □ Yes □ No

### Step 4: Record Initial State

```bash
kubectl get namespaces
kubectl get pods
```

**Number of namespaces:** ___________

**Number of pods in default:** ___________

---

## 3. Application Deployment

### Deploy the Application

**Windows:**
```powershell
.\deploy.ps1
```

**Linux/Mac:**
```bash
chmod +x deploy.sh
./deploy.sh
```

**✓ Deployment successful?** □ Yes □ No

### Explore Resources

```bash
kubectl get all -n k8s-lab
```

**Record Your Findings:**

Number of pods: ___________

Number of services: ___________

Number of deployments: ___________

Pod names:
1. ___________________________________
2. ___________________________________

---

## 4. Exploring Namespaces

### List Namespaces

```bash
kubectl get namespaces
```

**Total namespaces now:** ___________

**New namespace created:** ___________

### Compare Namespaces

```bash
kubectl get pods
kubectl get pods -n k8s-lab
```

**Question:** Why use namespaces?

**Your answer:**
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________

---

## 5. Working with Pods

### List Pods

```bash
kubectl get pods -n k8s-lab
```

### Describe a Pod

```bash
kubectl describe pod <flask-app-pod-name> -n k8s-lab
```

**Find and record:**

Image used: ___________

Pod status: ___________

Number of containers: ___________

Node: ___________

### View Logs

```bash
kubectl logs <flask-app-pod-name> -n k8s-lab
kubectl logs <postgres-pod-name> -n k8s-lab
```

**✓ Application healthy?** □ Yes □ No

### Execute Commands Inside Pod

```bash
kubectl exec -it <flask-app-pod-name> -n k8s-lab -- /bin/sh
```

Inside the pod:
```bash
ls
pwd
env | grep DB
exit
```

**Environment variables found:**
_________________________________________________________________
_________________________________________________________________

---

## 6. Understanding Services

### List Services

```bash
kubectl get services -n k8s-lab
```

**Number of services:** ___________

**Service types:**
- postgres-service: ___________
- flask-app-service: ___________

### Describe Service

```bash
kubectl describe service flask-app-service -n k8s-lab
```

**Record:**

Type: ___________

Port: ___________

NodePort: ___________

Endpoints: ___________

### Access Application

```bash
minikube service flask-app-service -n k8s-lab
```

**✓ Application accessible?** □ Yes □ No

**Application URL:** ___________________________________________

---

## 7. Managing Deployments

### View Deployments

```bash
kubectl get deployments -n k8s-lab
kubectl describe deployment flask-app -n k8s-lab
```

**Current replicas:** ___________

**Desired replicas:** ___________

**Strategy type:** ___________

### Scale Up

```bash
kubectl scale deployment flask-app --replicas=3 -n k8s-lab
kubectl get pods -n k8s-lab
```

**Flask app pods now:** ___________

### Scale Down

```bash
kubectl scale deployment flask-app --replicas=1 -n k8s-lab
```

### Test Self-Healing

```bash
kubectl get pods -n k8s-lab
kubectl delete pod <flask-app-pod-name> -n k8s-lab
kubectl get pods -n k8s-lab
```

**What happened?**
_________________________________________________________________
_________________________________________________________________

**✓ New pod created automatically?** □ Yes □ No

---

## 8. ConfigMaps and Secrets

### View ConfigMap

```bash
kubectl get configmaps -n k8s-lab
kubectl describe configmap app-config -n k8s-lab
```

**Configuration stored:**
_________________________________________________________________
_________________________________________________________________

### View Secret

```bash
kubectl get secrets -n k8s-lab
kubectl describe secret app-secret -n k8s-lab
```

**Encoding used:** ___________

### BONUS: Decode Secret

```bash
kubectl get secret app-secret -n k8s-lab -o yaml
```

**Decoded password:** ___________

---

## 9. Testing the Application

### Get URL

```bash
minikube service flask-app-service -n k8s-lab --url
```

**URL:** ___________________________________________

### Test Health

```bash
curl <URL>/health
```

**Database connected?** □ Yes □ No

### Create Messages

```bash
# Windows PowerShell
Invoke-RestMethod -Uri "<URL>/messages" -Method POST -ContentType "application/json" -Body '{"message":"Hello Kubernetes!"}'

# Linux/Mac
curl -X POST <URL>/messages -H "Content-Type: application/json" -d '{"message":"Hello Kubernetes!"}'
```

### Retrieve Messages

```bash
curl <URL>/messages
```

**Number of messages:** ___________

### Test Persistence

```bash
kubectl delete pod <postgres-pod-name> -n k8s-lab
# Wait for new pod
kubectl get pods -n k8s-lab -w
# Test again
curl <URL>/messages
```

**Messages still there?** □ Yes □ No

---

## 10. Resource Exploration

### View All Resources

```bash
kubectl get all -n k8s-lab
```

### View YAML

```bash
kubectl get deployment flask-app -n k8s-lab -o yaml
kubectl get service flask-app-service -n k8s-lab -o yaml
```

### Check Events

```bash
kubectl get events -n k8s-lab --sort-by='.lastTimestamp'
```

**Latest event:**
_________________________________________________________________

---

## 11. Troubleshooting Practice

### Create Problem

```bash
kubectl scale deployment flask-app --replicas=5 -n k8s-lab
kubectl get pods -n k8s-lab
```

**All 5 pods running?** □ Yes □ No

**Status observed:** ___________

### Investigate

```bash
kubectl describe pod <pod-name> -n k8s-lab
kubectl get events -n k8s-lab --sort-by='.lastTimestamp'
```

**Issue identified:**
_________________________________________________________________
_________________________________________________________________

### Fix

```bash
kubectl scale deployment flask-app --replicas=1 -n k8s-lab
```

---

## 12. Cleanup

### Record Final State

```bash
kubectl get all -n k8s-lab
```

**Final counts:**
- Pods: ___________
- Services: ___________
- Deployments: ___________

### Delete Resources

**Windows:**
```powershell
.\cleanup.ps1
```

**Linux/Mac:**
```bash
./cleanup.sh
```

### Verify

```bash
kubectl get namespaces
kubectl get pods -n k8s-lab
```

**Error message received:**
_________________________________________________________________

---

## 13. Bonus Challenges (Optional)

### Challenge 1: Redeploy and Modify
□ Deploy application again
□ Scale to 2 replicas
□ Change NodePort to 30090
□ Access on new port

### Challenge 2: Explore ReplicaSets
```bash
kubectl get replicasets -n k8s-lab
kubectl describe replicaset <name> -n k8s-lab
```

**How does ReplicaSet relate to Deployment?**
_________________________________________________________________
_________________________________________________________________

### Challenge 3: Create Your Own Pod
```bash
kubectl run nginx --image=nginx -n k8s-lab
kubectl get pods -n k8s-lab
kubectl delete pod nginx -n k8s-lab
```

**✓ Completed?** □ Yes □ No

---

## 14. Lab Summary

### Key Concepts Learned

Check off what you understand:

□ **Pods** - Smallest deployable units
□ **Deployments** - Manage replica sets
□ **Services** - Network endpoints
□ **Namespaces** - Resource isolation
□ **ConfigMaps** - Configuration data
□ **Secrets** - Sensitive information
□ **Scaling** - Adjust replicas
□ **Self-Healing** - Automatic recovery

### Key Commands Mastered

□ `kubectl get`
□ `kubectl describe`
□ `kubectl logs`
□ `kubectl exec`
□ `kubectl scale`
□ `kubectl delete`
□ `kubectl apply`

---

## 15. Reflection

### Question 1
**What was the most interesting thing you learned?**

_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________

### Question 2
**What concept was most challenging?**

_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________

### Question 3
**How would you explain Kubernetes to someone new?**

_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________

### Question 4
**What questions do you still have?**

_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________

### Question 5
**How confident are you with Kubernetes now?** (1-5)

□ 1 - Not confident
□ 2 - Slightly confident
□ 3 - Moderately confident
□ 4 - Very confident
□ 5 - Extremely confident

---

## Additional Resources

- Kubernetes Docs: https://kubernetes.io/docs/
- kubectl Cheat Sheet: https://kubernetes.io/docs/reference/kubectl/cheatsheet/
- Minikube Docs: https://minikube.sigs.k8s.io/docs/

---

## Completion Certificate

I, ________________________________, have successfully completed the Kubernetes 101 Hands-On Lab.

**Date:** _______________

**Instructor Signature:** _______________________________

---

**Congratulations on completing the lab!** 🎉

---

## Notes Section

Use this space for additional notes:

_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
