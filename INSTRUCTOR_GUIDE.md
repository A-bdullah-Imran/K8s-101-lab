# Kubernetes 101 Lab - Instructor Guide

## Overview

This guide provides instructors with teaching notes, answer keys, and tips for running the Kubernetes 101 practical lab effectively.

### Learning Outcomes

By completing this lab, students will be able to:
- Deploy multi-container applications on Kubernetes
- Work with core Kubernetes resources (Pods, Deployments, Services)
- Understand Kubernetes concepts (Namespaces, ConfigMaps, Secrets)
- Use kubectl to inspect and manage resources
- Scale applications and observe self-healing
- Troubleshoot basic Kubernetes issues

### Prerequisites

Students should have:
- Basic understanding of containers and Docker
- Familiarity with command-line interfaces
- Completed the Kubernetes 101 theory session
- Minikube, kubectl, and Docker installed on their machines

### Lab Duration

- **Core Lab**: 60-90 minutes
- **With Bonus Challenges**: 90-120 minutes

---

## Pre-Lab Setup

### Instructor Preparation

1. **Test the Lab**: Run through the entire lab before class
2. **Verify Infrastructure**: Ensure students can access Minikube
3. **Prepare Troubleshooting**: Have common solutions ready
4. **Set Expectations**: Explain the interactive, hands-on nature

### Student Environment Verification

Before starting, verify each student has:

```bash
minikube version    # Should return a version number
kubectl version     # Should return client version
docker --version    # Should return Docker version
```

### Common Pre-Lab Issues

| Issue | Solution |
|-------|----------|
| Minikube won't start | Check virtualization is enabled in BIOS |
| kubectl not found | Add kubectl to PATH |
| Docker daemon not running | Start Docker Desktop |
| Permission errors | Run as admin/sudo (Windows/Linux) |

---

## Teaching Tips

### Part 1: Environment Setup

**Key Points to Emphasize:**
- Minikube creates a local Kubernetes cluster for development
- kubectl is the command-line tool for interacting with Kubernetes
- Always verify your environment before deploying

**Common Questions:**
- *"What's the difference between Minikube and Kubernetes?"*
  - Minikube is a tool that runs a single-node Kubernetes cluster locally
- *"Do we use Minikube in production?"*
  - No, Minikube is for development/learning. Production uses managed services (EKS, GKE, AKS)

### Part 2: Application Deployment

**Key Points:**
- The deployment script automates multiple steps
- In real scenarios, you'd often use CI/CD pipelines
- The application consists of two tiers: app and database

**Things to Watch:**
- Students may try to run the script from the wrong directory
- Docker image build can take time on slower machines
- Some students may see warnings - explain which are safe to ignore

### Part 3: Understanding Namespaces

**Answer Key:**
- **Initial namespaces**: Typically 4 (default, kube-system, kube-public, kube-node-lease)
- **After deployment**: One additional namespace (k8s-lab)

**Key Concepts:**
- Namespaces provide logical isolation
- They're like virtual clusters within a cluster
- Useful for multi-tenancy, separating environments

**Discussion Points:**
- When would you use multiple namespaces?
- How do namespaces relate to resource quotas?

### Part 4: Working with Pods

**Answer Key Examples:**

**Step 4.2 (Describe Pod):**
- Image: flask-k8s-app:latest
- Status: Running
- Containers: 1
- Node: minikube

**Step 4.4 (Environment Variables):**
Students should see:
- DB_HOST=postgres-service
- DB_PORT=5432
- DB_NAME=appdb
- DB_USER=postgres
- DB_PASSWORD=postgres123

**Key Concepts:**
- Pods are the smallest deployable units
- Pods can have multiple containers (sidecar pattern)
- Containers in a pod share network and storage

**Demonstration Tip:**
Show students how to read `kubectl describe` output systematically:
1. Metadata section
2. Spec section
3. Status section
4. Events section

### Part 5: Understanding Services

**Answer Key:**

**Step 5.1:**
- Number of services: 2
- postgres-service: ClusterIP
- flask-app-service: NodePort

**Step 5.2:**
- Service Type: NodePort
- Port: 5000
- NodePort: 30080
- Endpoints: Should show the pod IP and port

**Key Concepts:**
- Services provide stable endpoints for pods
- ClusterIP: Internal cluster access only
- NodePort: External access via node IP:port
- LoadBalancer: Cloud provider load balancer (doesn't work in Minikube)

**Common Confusion:**
Students often confuse:
- Port (service port) vs TargetPort (pod port) vs NodePort (external port)

**Visualization Tip:**
Draw on whiteboard: User → NodePort → Service → Pod

### Part 6: Working with Deployments

**Answer Key:**

**Step 6.2:**
- Current replicas: 1
- Desired replicas: 1
- Strategy type: RollingUpdate

**Step 6.3:**
- After scaling: 3 Flask app pods

**Step 6.6 (Self-Healing):**
Students should observe that after deleting a pod, Kubernetes immediately creates a new one to maintain the desired state.

**Key Concepts:**
- Deployments manage ReplicaSets
- ReplicaSets ensure the desired number of pods are running
- Self-healing is automatic
- Declarative management: "desired state" vs "current state"

**Live Demo Suggestion:**
1. Scale to 3 replicas
2. In one terminal, run `kubectl get pods -w`
3. In another, delete a pod
4. Students see real-time pod termination and creation

### Part 7: ConfigMaps and Secrets

**Answer Key:**

**Step 7.1 (ConfigMap Data):**
- DB_HOST: postgres-service
- DB_PORT: 5432
- DB_NAME: appdb
- DB_USER: postgres

**Step 7.4:**
- Encoding: Base64
- Decoded password: postgres123

**Decode Commands:**
```bash
# Linux/Mac
echo "cG9zdGdyZXMxMjM=" | base64 -d

# Windows PowerShell
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("cG9zdGdyZXMxMjM="))
```

**Key Concepts:**
- ConfigMaps: Non-sensitive configuration
- Secrets: Sensitive data (passwords, tokens, keys)
- Base64 encoding ≠ encryption (important security note!)
- In production, use proper secret management (Vault, AWS Secrets Manager, etc.)

**Security Discussion:**
- Secrets in Kubernetes are base64 encoded, not encrypted by default
- etcd encryption should be enabled in production
- Use external secret management for sensitive production data

### Part 8: Testing the Application

**Answer Key:**

**Step 8.2:**
- Database should be "connected"

**Step 8.4:**
- Should see 2 messages (if both POST requests succeeded)

**Step 8.5:**
- Messages may or may not persist depending on timing (emptyDir is ephemeral)

**Key Concepts:**
- RESTful APIs and HTTP methods
- Data persistence vs ephemeral storage
- PersistentVolumes for stateful workloads

**Discussion:**
- What happens to data when a pod is deleted?
- When would you use PersistentVolumes?
- How does Kubernetes handle stateful applications?

### Part 9: Exploring Resource Details

**Teaching Focus:**
- YAML is the declarative format for Kubernetes resources
- Understanding resource manifests helps debug issues
- The `-o yaml` flag shows the complete resource definition

**Advanced Topic (if time permits):**
- Show the difference between desired spec and current status
- Explain how Kubernetes controllers work

### Part 10: Troubleshooting Practice

**Expected Behavior:**
- 5 replicas might work on some machines but not others
- Depends on resource availability (CPU, memory)
- Some pods may be Pending or have resource constraints

**Answer Key:**
- Not all 5 pods may run due to resource limits
- Status might show: Pending, ContainerCreating, or Running
- Events will show resource constraint messages if applicable

**Teaching Points:**
- Troubleshooting workflow: get pods → describe pod → check events → check logs
- Resource requests and limits matter
- Understanding pod lifecycle phases

### Part 11: Cleanup

**Answer Key:**

**Step 11.3:**
- Message: "Error from server (NotFound): namespaces 'k8s-lab' not found"

**Key Concepts:**
- Deleting a namespace deletes all resources within it
- Always clean up resources after labs
- Namespace deletion is a quick way to remove everything

---

## Answer Key Summary

### Resource Counts

| Resource | Initial | After Deployment |
|----------|---------|------------------|
| Namespaces | 4 | 5 |
| Pods (k8s-lab) | 0 | 2 |
| Services (k8s-lab) | 0 | 2 |
| Deployments (k8s-lab) | 0 | 2 |

### Service Types

- **postgres-service**: ClusterIP (internal only)
- **flask-app-service**: NodePort (external access)

### Secrets Decoding

- Password encoding: Base64
- DB_PASSWORD value: postgres123

### Key kubectl Commands Used

```bash
# Viewing resources
kubectl get <resource>
kubectl describe <resource> <name>
kubectl logs <pod-name>

# Manipulating resources
kubectl scale deployment <name> --replicas=<n>
kubectl delete <resource> <name>
kubectl exec -it <pod-name> -- <command>

# Namespace operations
kubectl get <resource> -n <namespace>
kubectl apply -f <file>
```

---

## Common Student Issues

### Issue 1: "Cannot connect to Docker daemon"

**Symptoms:**
```
Error response from daemon: Cannot connect to the Docker daemon
```

**Solution:**
1. Ensure Docker Desktop is running
2. On Windows, run PowerShell as Administrator
3. Verify: `docker ps` works
4. Configure Minikube's Docker environment: `minikube docker-env`

### Issue 2: "Pods stuck in Pending state"

**Symptoms:**
```
NAME                         READY   STATUS    RESTARTS   AGE
flask-app-xyz                0/1     Pending   0          2m
```

**Solution:**
1. Check events: `kubectl describe pod <pod-name>`
2. Usually resource constraints
3. Check node resources: `kubectl describe node minikube`
4. May need to restart Minikube with more resources: `minikube start --memory=4096 --cpus=2`

### Issue 3: "Image pull errors"

**Symptoms:**
```
Failed to pull image "flask-k8s-app:latest": image not found
```

**Solution:**
1. Verify Docker environment is configured: `minikube docker-env`
2. Re-run the deploy script
3. Check image exists: `docker images | grep flask-k8s-app`
4. Ensure `imagePullPolicy: Never` is set in the deployment

### Issue 4: "Service not accessible"

**Symptoms:**
- `minikube service` command doesn't work
- Cannot curl the application

**Solution:**
1. Verify pods are running: `kubectl get pods -n k8s-lab`
2. Check service endpoints: `kubectl describe service flask-app-service -n k8s-lab`
3. Use `minikube service flask-app-service -n k8s-lab --url` to get the correct URL
4. On Windows, ensure no firewall blocking

### Issue 5: "Database connection errors in logs"

**Symptoms:**
```
Error: Database connection failed
```

**Solution:**
1. Check if postgres pod is running: `kubectl get pods -n k8s-lab`
2. Verify service: `kubectl get service postgres-service -n k8s-lab`
3. Check postgres logs: `kubectl logs <postgres-pod-name> -n k8s-lab`
4. Wait longer - postgres might still be starting up
5. Verify environment variables in flask app pod

---

## Extension Activities

### For Fast Learners

1. **Add Persistent Storage**
   - Modify postgres deployment to use a PersistentVolumeClaim
   - Test data persistence across pod deletions

2. **Add Ingress**
   - Enable Ingress in Minikube: `minikube addons enable ingress`
   - Create an Ingress resource to route traffic

3. **Implement Resource Limits**
   - Add resource requests and limits
   - Observe behavior when limits are exceeded

4. **Health Checks**
   - Analyze the existing liveness and readiness probes
   - Modify probe parameters and observe effects

5. **Rolling Updates**
   - Make a change to the application code
   - Rebuild the image with a new tag
   - Update the deployment and watch rolling update

### Group Activities

1. **Troubleshooting Challenge**
   - Intentionally break a deployment (wrong image, wrong port, etc.)
   - Have groups debug and fix it

2. **Architecture Design**
   - Have students design a 3-tier application
   - Draw the pod, service, and deployment architecture

3. **Real-World Scenario**
   - "Your app is down in production. You have 5 minutes to diagnose."
   - Practice: checking pods → logs → events → services

---

## Assessment Ideas

### Knowledge Check Questions

1. **Conceptual:**
   - What's the difference between a Pod and a Deployment?
   - Why do we use Services instead of accessing Pods directly?
   - When should you use a ConfigMap vs a Secret?

2. **Practical:**
   - Scale the application to 4 replicas
   - Find the IP address of a specific pod
   - Change the database password and redeploy

3. **Troubleshooting:**
   - Given error logs, identify the issue
   - A pod won't start - what steps would you take?

### Lab Report Template

Students submit a document with:
1. Screenshots of key commands and outputs
2. Answers to all questions in the lab guide
3. One challenge they faced and how they solved it
4. One thing they learned that surprised them

---

## Additional Resources for Students

### Recommended Reading
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Play with Kubernetes](https://labs.play-with-k8s.com/)

### Video Resources
- Kubernetes Basics (official tutorials)
- TechWorld with Nana - Kubernetes Tutorial for Beginners

### Practice Environments
- Minikube (local)
- Kind (Kubernetes in Docker)
- K3s (lightweight Kubernetes)
- Cloud provider free tiers (GKE, EKS, AKS)

---

## Post-Lab Discussion

### Discussion Questions

1. **Real-World Application:**
   - How would you use Kubernetes in your projects?
   - What challenges do you foresee?

2. **Comparison:**
   - How does Kubernetes compare to traditional deployment methods?
   - What are the trade-offs?

3. **Next Steps:**
   - What Kubernetes topics do you want to learn next?
   - How can you practice more?

### Key Takeaways to Reinforce

✅ Kubernetes manages containerized applications declaratively
✅ Pods are ephemeral; Deployments ensure desired state
✅ Services provide stable networking for dynamic pods
✅ Namespaces isolate resources
✅ ConfigMaps and Secrets decouple configuration from code
✅ kubectl is your primary tool for cluster interaction

---

## Lab Variations

### Shorter Version (45 minutes)

Focus on:
- Parts 1-6 only
- Skip bonus challenges
- Provide pre-built Docker image

### Advanced Version (2-3 hours)

Add:
- Persistent volumes
- Ingress controllers
- Horizontal Pod Autoscaling
- Network policies
- StatefulSets

### Team Version

- Divide class into teams
- Each team deploys their own version
- Competition: first to scale to 10 replicas and pass health checks

---

## Feedback Collection

### End-of-Lab Survey

Ask students:
1. How confident do you feel with Kubernetes now? (1-5)
2. What was the most valuable part of this lab?
3. What was most confusing?
4. How can we improve this lab?
5. What would you like to learn next?

### Instructor Self-Assessment

After each lab:
- What went well?
- What issues did students face?
- How can I improve explanations?
- What timing adjustments are needed?

---

## Quick Reference

### Essential Commands for Demos

```bash
# Quick cluster info
kubectl cluster-info
kubectl get nodes

# Common operations
kubectl get all -n k8s-lab
kubectl get pods -n k8s-lab -w
kubectl logs -f <pod-name> -n k8s-lab
kubectl describe pod <pod-name> -n k8s-lab

# Scaling and healing demo
kubectl scale deployment flask-app --replicas=3 -n k8s-lab
kubectl delete pod <pod-name> -n k8s-lab

# Cleanup
kubectl delete namespace k8s-lab
```

### Useful Minikube Commands

```bash
minikube start
minikube stop
minikube status
minikube dashboard
minikube service list
minikube ssh
```

---

## Conclusion

This lab provides a comprehensive introduction to Kubernetes through hands-on practice. Students learn by doing, which reinforces theoretical concepts covered in lectures. The interactive nature keeps students engaged while building confidence with kubectl and Kubernetes concepts.

**Good luck with your class!** 🚀

---

## Appendix: Setup Script for Multiple Students

If teaching a class with many students, use this script to verify all students are ready:

```bash
#!/bin/bash
echo "Student Environment Check"
echo "========================="
echo ""

echo "1. Checking Minikube..."
minikube version || echo "❌ Minikube not found"

echo ""
echo "2. Checking kubectl..."
kubectl version --client || echo "❌ kubectl not found"

echo ""
echo "3. Checking Docker..."
docker --version || echo "❌ Docker not found"

echo ""
echo "4. Checking Minikube status..."
minikube status || echo "⚠️  Minikube not running - run 'minikube start'"

echo ""
echo "Setup check complete!"
```

Save as `check-environment.sh` and have students run it before the lab.
