# Kubernetes 101 Lab - Quick Reference Cheat Sheet

## Essential kubectl Commands

### Viewing Resources

```bash
# List all resources in namespace
kubectl get all -n k8s-lab

# List specific resources
kubectl get pods -n k8s-lab
kubectl get services -n k8s-lab
kubectl get deployments -n k8s-lab
kubectl get namespaces

# Watch resources in real-time
kubectl get pods -n k8s-lab -w

# Get detailed information
kubectl describe pod <pod-name> -n k8s-lab
kubectl describe service <service-name> -n k8s-lab
kubectl describe deployment <deployment-name> -n k8s-lab

# View YAML definition
kubectl get pod <pod-name> -n k8s-lab -o yaml
kubectl get service <service-name> -n k8s-lab -o yaml
```

### Working with Pods

```bash
# View pod logs
kubectl logs <pod-name> -n k8s-lab

# Follow logs in real-time
kubectl logs -f <pod-name> -n k8s-lab

# Execute commands in a pod
kubectl exec -it <pod-name> -n k8s-lab -- /bin/sh

# Delete a pod
kubectl delete pod <pod-name> -n k8s-lab
```

### Scaling and Managing Deployments

```bash
# Scale deployment
kubectl scale deployment <deployment-name> --replicas=3 -n k8s-lab

# View deployment status
kubectl rollout status deployment/<deployment-name> -n k8s-lab

# View deployment history
kubectl rollout history deployment/<deployment-name> -n k8s-lab
```

### ConfigMaps and Secrets

```bash
# View ConfigMaps
kubectl get configmaps -n k8s-lab
kubectl describe configmap <configmap-name> -n k8s-lab

# View Secrets
kubectl get secrets -n k8s-lab
kubectl describe secret <secret-name> -n k8s-lab

# View secret values (base64 encoded)
kubectl get secret <secret-name> -n k8s-lab -o yaml
```

### Applying Resources

```bash
# Apply a single file
kubectl apply -f <file.yaml>

# Apply all files in a directory
kubectl apply -f k8s-manifests/

# Delete resources
kubectl delete -f <file.yaml>
kubectl delete namespace <namespace-name>
```

### Namespace Operations

```bash
# List all namespaces
kubectl get namespaces

# Create a namespace
kubectl create namespace <name>

# Delete a namespace (deletes all resources in it)
kubectl delete namespace <name>

# Set default namespace
kubectl config set-context --current --namespace=<name>
```

## Minikube Commands

```bash
# Start Minikube
minikube start

# Stop Minikube
minikube stop

# Check status
minikube status

# Delete cluster
minikube delete

# Access service
minikube service <service-name> -n <namespace>

# Get service URL
minikube service <service-name> -n <namespace> --url

# Open dashboard
minikube dashboard

# SSH into Minikube
minikube ssh

# Configure Docker to use Minikube
minikube docker-env
# PowerShell
& minikube -p minikube docker-env --shell powershell | Invoke-Expression
# Bash
eval $(minikube docker-env)

# View addons
minikube addons list

# Enable an addon
minikube addons enable <addon-name>
```

## Docker Commands (in Minikube context)

```bash
# List images
docker images

# Build an image
docker build -t <image-name>:<tag> .

# Remove an image
docker rmi <image-name>:<tag>
```

## Troubleshooting Commands

```bash
# Check cluster info
kubectl cluster-info

# View cluster nodes
kubectl get nodes

# Describe a node
kubectl describe node <node-name>

# View events
kubectl get events -n k8s-lab
kubectl get events -n k8s-lab --sort-by='.lastTimestamp'

# Check resource usage
kubectl top nodes
kubectl top pods -n k8s-lab

# Port forward to a pod
kubectl port-forward <pod-name> <local-port>:<pod-port> -n k8s-lab
```

## Lab-Specific Commands

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

### Access the Application

```bash
minikube service flask-app-service -n k8s-lab
```

### Test the Application

```bash
# Get the URL
minikube service flask-app-service -n k8s-lab --url

# Test endpoints (replace <URL> with actual URL)
curl <URL>/
curl <URL>/health
curl <URL>/messages

# Create a message
curl -X POST <URL>/messages -H "Content-Type: application/json" -d '{"message":"Hello K8s!"}'
```

### Cleanup

**Windows:**
```powershell
.\cleanup.ps1
```

**Linux/Mac:**
```bash
./cleanup.sh
```

## Common kubectl Shortcuts

```bash
# Shortcuts for resource types
po    = pods
svc   = services
deploy = deployments
cm    = configmaps
ns    = namespaces

# Examples
kubectl get po -n k8s-lab
kubectl get svc -n k8s-lab
kubectl get deploy -n k8s-lab
```

## Useful Flags

```bash
-n <namespace>    # Specify namespace
-o yaml           # Output in YAML format
-o json           # Output in JSON format
-o wide           # Show more details
-w                # Watch for changes
--all-namespaces  # All namespaces (or -A)
-f <file>         # Specify file
--help            # Show help
```

## Tips and Tricks

### View All Resources in All Namespaces

```bash
kubectl get all --all-namespaces
# or
kubectl get all -A
```

### Get Pod Names Programmatically

```bash
# Get first pod name matching label
kubectl get pods -n k8s-lab -l app=flask-app -o jsonpath='{.items[0].metadata.name}'
```

### Decode a Secret

**Linux/Mac:**
```bash
kubectl get secret app-secret -n k8s-lab -o jsonpath='{.data.DB_PASSWORD}' | base64 -d
```

**Windows PowerShell:**
```powershell
$secret = kubectl get secret app-secret -n k8s-lab -o jsonpath='{.data.DB_PASSWORD}'
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($secret))
```

### Delete All Pods (they will be recreated)

```bash
kubectl delete pods --all -n k8s-lab
```

### Copy Files to/from Pods

```bash
# Copy TO pod
kubectl cp <local-file> <pod-name>:<path> -n k8s-lab

# Copy FROM pod
kubectl cp <pod-name>:<path> <local-file> -n k8s-lab
```

## Resource Types Quick Reference

| Resource | Description |
|----------|-------------|
| Pod | Smallest deployable unit, one or more containers |
| Deployment | Manages ReplicaSets and rolling updates |
| ReplicaSet | Ensures specified number of pod replicas |
| Service | Network endpoint for pods |
| Namespace | Virtual cluster for resource isolation |
| ConfigMap | Non-sensitive configuration data |
| Secret | Sensitive data (base64 encoded) |
| Volume | Storage for pods |
| Ingress | HTTP/HTTPS routing to services |

## Service Types

| Type | Description |
|------|-------------|
| ClusterIP | Internal cluster access only (default) |
| NodePort | Exposes service on each node's IP at a static port |
| LoadBalancer | Cloud provider load balancer |
| ExternalName | Maps service to DNS name |

## Pod Lifecycle Phases

| Phase | Description |
|-------|-------------|
| Pending | Accepted but not yet running |
| Running | Pod is running on a node |
| Succeeded | All containers terminated successfully |
| Failed | At least one container failed |
| Unknown | State cannot be determined |

## Quick Debugging Workflow

1. **Check pods**: `kubectl get pods -n k8s-lab`
2. **Describe pod**: `kubectl describe pod <pod-name> -n k8s-lab`
3. **Check logs**: `kubectl logs <pod-name> -n k8s-lab`
4. **Check events**: `kubectl get events -n k8s-lab --sort-by='.lastTimestamp'`
5. **Check service**: `kubectl describe service <service-name> -n k8s-lab`
6. **Exec into pod**: `kubectl exec -it <pod-name> -n k8s-lab -- /bin/sh`

---

**Keep this cheat sheet handy during the lab!** 📝
