# Kubernetes 101 - Hands-On Lab Guide

## Introduction

Welcome to your first Kubernetes practical lab! In this hands-on session, you'll deploy a real application on Kubernetes using Minikube and learn how to interact with pods, services, deployments, and other core Kubernetes resources.

### What We're Building

You'll deploy a simple message application consisting of:
- **Flask Web API**: A Python application that provides REST endpoints
- **PostgreSQL Database**: A database to store messages

### Lab Objectives

By the end of this lab, you will be able to:
- Deploy applications to Kubernetes
- Understand and work with Pods, Deployments, Services
- Use ConfigMaps and Secrets for configuration
- Work with Namespaces
- Scale applications
- Troubleshoot common issues
- View logs and describe resources

### Time Required

Approximately 60-90 minutes

---

## Part 1: Environment Setup (10 minutes)

### Step 1.1: Verify Prerequisites

First, let's make sure your environment is ready:

```bash
# Check Minikube version
minikube version

# Check kubectl version
kubectl version --client

# Check Docker version
docker --version
```

**💡 What These Tools Do:**
- **Minikube**: Creates a local Kubernetes cluster on your computer for development and learning
- **kubectl**: Command-line tool to interact with Kubernetes clusters (your main tool!)
- **Docker**: Builds and runs containers that Kubernetes orchestrates

### Step 1.2: Start Minikube

If Minikube is not running, start it:

```bash
minikube start
```

**📚 What This Does:**
This command creates a single-node Kubernetes cluster on your machine. It:
- Downloads Kubernetes components (first time only)
- Starts a virtual machine or container
- Configures kubectl to connect to your local cluster
- Takes 2-5 minutes on first run

Once complete, verify it's running:

```bash
minikube status
```

**Expected Output:**
```
minikube
type: Control Plane
host: Running
kubelet: Running
api

### Step 1.3: Verify Kubectl Connection

```bash
kubectl cluster-info
```

You should see information about your Kubernetes cluster.

### Step 1.4: Check Current Resources

Before we start, let's see what's currently in the cluster:

```bash
# List all namespaces
kubectl get namespaces

# List all pods (in default namespace)
kubectl get pods

# How many namespaces do you see? ___________
# How many pods in the default namespace? ___________
```

**Record your answers** - we'll compare these later!

---

## Part 2: Application Deployment (15 minutes)

### Step 2.1: Deploy the Application

Use the provided deployment script:

**Windows (PowerShell):**
```powershell
.\deploy.ps1
```

**Linux/Mac (Bash):**
```bash
chmod +x deploy.sh
./deploy.sh
```

Watch the output as it:
1. Builds the Docker image
2. Creates a namespace
3. Creates ConfigMaps and Secrets
4. Deploys PostgreSQL
5. Deploys the Flask application

### Step 2.2: Understand What Was Created

Let's explore what was deployed:

```bash
# View all resources in the k8s-lab namespace
kubectl get all -n k8s-lab
```

**Questions to Answer:**
1. How many pods are running? ___________
2. How many services do you see? ___________
3. How many deployments? ___________
4. What are the names of the pods? 
   - ___________________________
   - ___________________________

---

## Part 3: Understanding Namespaces (10 minutes)

### Step 3.1: List All Namespaces

```bash
kubectl get namespaces
```

**Question:** How many namespaces exist now? ___________

Compare this to your answer from Step 1.4. What's different?

### Step 3.2: Explore the k8s-lab Namespace

```bash
# View all resources in k8s-lab namespace
kubectl get all -n k8s-lab

# View configmaps
kubectl get configmaps -n k8s-lab

# View secrets
kubectl get secrets -n k8s-lab
```

### Step 3.3: Compare with Default Namespace

```bash
# View pods in default namespace
kubectl get pods

# View pods in k8s-lab namespace
kubectl get pods -n k8s-lab
```

**Question:** Why do we use namespaces? What's the benefit?

Write your answer: ___________________________________________________________

---

## Part 4: Working with Pods (15 minutes)

### Step 4.1: List Pods

```bash
kubectl get pods -n k8s-lab
```

### Step 4.2: Get Detailed Pod Information

Replace `<pod-name>` with one of your pod names:

```bash
kubectl describe pod <flask-app-pod-name> -n k8s-lab
```

**Explore the output and answer:**
1. What image is the pod using? ___________
2. What is the pod's status? ___________
3. How many containers are in the pod? ___________
4. What node is it running on? ___________

### Step 4.3: View Pod Logs

```bash
# View Flask app logs
kubectl logs <flask-app-pod-name> -n k8s-lab

# View PostgreSQL logs
kubectl logs <postgres-pod-name> -n k8s-lab
```

**Question:** What do you see in the logs? Is the application healthy?

### Step 4.4: Execute Commands Inside a Pod

```bash
# Get a shell inside the Flask app pod
kubectl exec -it <flask-app-pod-name> -n k8s-lab -- /bin/sh

# Once inside, try these commands:
ls
pwd
env | grep DB
exit
```

**Question:** What environment variables did you see related to the database?

---

## Part 5: Understanding Services (10 minutes)

### Step 5.1: List Services

```bash
kubectl get services -n k8s-lab
```

or shorthand:

```bash
kubectl get svc -n k8s-lab
```

**Answer these questions:**
1. How many services are there? ___________
2. What types of services are they? (ClusterIP, NodePort, LoadBalancer?)
   - postgres-service: ___________
   - flask-app-service: ___________

### Step 5.2: Describe a Service

```bash
kubectl describe service flask-app-service -n k8s-lab
```

**Find and record:**
1. Service Type: ___________
2. Port: ___________
3. NodePort: ___________
4. Endpoints: ___________

### Step 5.3: Access the Application

```bash
minikube service flask-app-service -n k8s-lab
```

This will open your browser to the application. You should see a JSON response with available endpoints.

**Try these endpoints in your browser or using curl:**

```bash
# Get the URL
minikube service flask-app-service -n k8s-lab --url

# Use the URL in these commands (replace <URL> with actual URL)
curl <URL>/
curl <URL>/health
curl <URL>/messages
```

---

## Part 6: Working with Deployments (15 minutes)

### Step 6.1: View Deployments

```bash
kubectl get deployments -n k8s-lab
```

### Step 6.2: Describe a Deployment

```bash
kubectl describe deployment flask-app -n k8s-lab
```

**Record:**
1. Current replicas: ___________
2. Desired replicas: ___________
3. Strategy type: ___________

### Step 6.3: Scale the Application

Let's scale our Flask application to 3 replicas:

```bash
kubectl scale deployment flask-app --replicas=3 -n k8s-lab
```

Now check the pods:

```bash
kubectl get pods -n k8s-lab
```

**Question:** How many Flask app pods do you see now? ___________

### Step 6.4: Watch Pods in Real-Time

Open a new terminal and run:

```bash
kubectl get pods -n k8s-lab -w
```

The `-w` flag watches for changes. Leave this running.

### Step 6.5: Scale Down

In your original terminal:

```bash
kubectl scale deployment flask-app --replicas=1 -n k8s-lab
```

**Question:** What did you observe in the watching terminal?

### Step 6.6: Automatic Healing

Let's see Kubernetes self-healing in action! Delete a pod:

```bash
# Get pod name
kubectl get pods -n k8s-lab

# Delete the flask-app pod
kubectl delete pod <flask-app-pod-name> -n k8s-lab
```

**Immediately check pods again:**

```bash
kubectl get pods -n k8s-lab
```

**Question:** What happened? Is there still a Flask app pod running?

Write your observation: ___________________________________________________________

This is Kubernetes' self-healing capability!

---

## Part 7: ConfigMaps and Secrets (10 minutes)

### Step 7.1: View ConfigMap

```bash
kubectl get configmaps -n k8s-lab

kubectl describe configmap app-config -n k8s-lab
```

**Question:** What configuration data is stored here?

### Step 7.2: View ConfigMap YAML

```bash
kubectl get configmap app-config -n k8s-lab -o yaml
```

### Step 7.3: View Secret

```bash
kubectl get secrets -n k8s-lab

kubectl describe secret app-secret -n k8s-lab
```

**Notice:** The actual secret values are not shown when describing!

### Step 7.4: Decode Secret (Carefully!)

```bash
# View the secret in YAML format
kubectl get secret app-secret -n k8s-lab -o yaml
```

**Question:** What encoding is used for secrets? ___________

**BONUS Challenge:** Try to decode the DB_PASSWORD value. 
(Hint: The value is base64 encoded. Look up how to decode base64)

Decoded password: ___________

---

## Part 8: Testing the Application (10 minutes)

### Step 8.1: Get the Application URL

```bash
minikube service flask-app-service -n k8s-lab --url
```

Save this URL, you'll use it in the following steps. Replace `<URL>` with your actual URL.

### Step 8.2: Test Health Endpoint

```bash
curl <URL>/health
```

**Question:** Is the database connected? ___________

### Step 8.3: Create Messages

```bash
# Create a message (Windows PowerShell)
Invoke-RestMethod -Uri "<URL>/messages" -Method POST -ContentType "application/json" -Body '{"message":"Hello Kubernetes!"}'

# Create a message (Linux/Mac/WSL)
curl -X POST <URL>/messages -H "Content-Type: application/json" -d '{"message":"Hello Kubernetes!"}'

# Create another message
curl -X POST <URL>/messages -H "Content-Type: application/json" -d '{"message":"Learning K8s is fun!"}'
```

### Step 8.4: Retrieve Messages

```bash
curl <URL>/messages
```

**Question:** How many messages do you see? ___________

### Step 8.5: Test Data Persistence

Let's test if data persists across pod restarts:

```bash
# Delete the postgres pod
kubectl delete pod <postgres-pod-name> -n k8s-lab

# Wait for the new pod to be ready
kubectl get pods -n k8s-lab -w

# Once ready, retrieve messages again
curl <URL>/messages
```

**Question:** Are your messages still there? ___________

**Note:** In this lab, we're using emptyDir storage, so data would be lost if the pod is deleted. In production, you'd use persistent volumes!

---

## Part 9: Exploring Resource Details (10 minutes)

### Step 9.1: View All Resources

```bash
kubectl get all -n k8s-lab
```

### Step 9.2: Get Resource YAML

```bash
# View the Flask deployment YAML
kubectl get deployment flask-app -n k8s-lab -o yaml

# View a service YAML
kubectl get service flask-app-service -n k8s-lab -o yaml
```

### Step 9.3: Check Resource Usage

```bash
kubectl top nodes

kubectl top pods -n k8s-lab
```

**Note:** If `top` doesn't work, metrics-server might not be installed. That's okay!

### Step 9.4: View Events

```bash
kubectl get events -n k8s-lab --sort-by='.lastTimestamp'
```

This shows recent events in your namespace.

---

## Part 10: Troubleshooting Practice (10 minutes)

### Step 10.1: Intentionally Break Something

Let's practice troubleshooting! Scale the Flask app to 5 replicas:

```bash
kubectl scale deployment flask-app --replicas=5 -n k8s-lab
```

### Step 10.2: Check Pod Status

```bash
kubectl get pods -n k8s-lab
```

**Questions:**
1. Are all 5 pods running? ___________
2. If not, what status do you see? ___________

### Step 10.3: Investigate

Use these commands to investigate:

```bash
# Describe pods that aren't running
kubectl describe pod <pod-name> -n k8s-lab

# Check events
kubectl get events -n k8s-lab --sort-by='.lastTimestamp'
```

### Step 10.4: Fix the Issue

Scale back down:

```bash
kubectl scale deployment flask-app --replicas=1 -n k8s-lab
```

---

## Part 11: Cleanup (5 minutes)

### Step 11.1: Before Cleanup - Record Final State

```bash
# Count resources before cleanup
kubectl get all -n k8s-lab
```

**Record:**
- Number of pods: ___________
- Number of services: ___________
- Number of deployments: ___________

### Step 11.2: Delete Everything

**Windows:**
```powershell
.\cleanup.ps1
```

**Linux/Mac:**
```bash
./cleanup.sh
```

### Step 11.3: Verify Cleanup

```bash
# Check if namespace is gone
kubectl get namespaces

# Try to list pods in k8s-lab namespace
kubectl get pods -n k8s-lab
```

**Question:** What message do you get? ___________

---

## Part 12: Bonus Challenges (Optional)

If you have extra time, try these challenges:

### Challenge 1: Deploy Again and Modify

1. Deploy the application again
2. Scale the Flask app to 2 replicas
3. Change the NodePort in the service to 30090
4. Access the application on the new port

### Challenge 2: Explore Replica Sets

```bash
kubectl get replicasets -n k8s-lab
kubectl describe replicaset <replicaset-name> -n k8s-lab
```

**Question:** How does a ReplicaSet relate to a Deployment?

### Challenge 3: Update Configuration

1. Update the ConfigMap to change a database setting
2. Restart the pods to pick up the change
3. Verify the change took effect

### Challenge 4: Create Your Own Resource

Try creating a simple pod using `kubectl run`:

```bash
kubectl run nginx --image=nginx -n k8s-lab
kubectl get pods -n k8s-lab
kubectl delete pod nginx -n k8s-lab
```

---

## Lab Summary

Congratulations! You've completed the Kubernetes 101 lab. Let's recap what you learned:

### Key Concepts Covered

✅ **Pods**: The smallest deployable units in Kubernetes
✅ **Deployments**: Manage replica sets and pod updates
✅ **Services**: Expose pods to network traffic
✅ **Namespaces**: Organize and isolate resources
✅ **ConfigMaps**: Store configuration data
✅ **Secrets**: Store sensitive information
✅ **Scaling**: Adjust the number of pod replicas
✅ **Self-Healing**: Automatic pod recovery

### Key Commands You Learned

- `kubectl get` - List resources
- `kubectl describe` - Detailed resource information
- `kubectl logs` - View pod logs
- `kubectl exec` - Execute commands in pods
- `kubectl scale` - Scale deployments
- `kubectl delete` - Remove resources
- `kubectl apply` - Create/update resources from files

### Next Steps

To continue your Kubernetes journey:

1. **Practice**: Deploy the lab multiple times
2. **Experiment**: Modify the YAML files and see what happens
3. **Learn More**: Explore persistent volumes, ingress, and stateful sets
4. **Build**: Create your own applications and deploy them on Kubernetes

---

## Reflection Questions

Take a moment to reflect on what you learned:

1. **What was the most interesting thing you learned?**

   ___________________________________________________________________________

2. **What concept was most challenging to understand?**

   ___________________________________________________________________________

3. **How would you explain Kubernetes to someone who's never heard of it?**

   ___________________________________________________________________________

4. **What questions do you still have?**

   ___________________________________________________________________________

---

## Additional Resources

- [Kubernetes Official Documentation](https://kubernetes.io/docs/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

---

**Great job completing the lab! 🎉**
