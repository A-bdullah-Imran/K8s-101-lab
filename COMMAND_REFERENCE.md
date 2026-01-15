# Kubernetes Commands - Learning Reference

This guide explains every command used in the lab, what it does, and why we use it.

---

## Part 1: Environment Setup Commands

### `minikube version`
**What it does:** Shows the installed Minikube version  
**Why we use it:** Verify Minikube is installed correctly  
**Example output:** `minikube version: v1.30.1`

### `kubectl version --client`
**What it does:** Shows the kubectl client version  
**Why we use it:** Confirm kubectl is installed and ready to use  
**Key point:** kubectl is your main tool for interacting with Kubernetes

### `docker --version`
**What it does:** Shows the Docker version  
**Why we use it:** Docker builds container images that Kubernetes runs  
**Example:** `Docker version 24.0.7`

###

 `minikube start`
**What it does:** Creates and starts a local Kubernetes cluster  
**Behind the scenes:**
- Downloads Kubernetes components (first time)
- Starts a VM or container runtime
- Configures kubectl to connect to the cluster
- Sets up networking

**Time:** 2-5 minutes first run, 30 seconds subsequent runs  
**💡 Think of it as:** Turning on your own mini Kubernetes cloud

### `minikube status`
**What it does:** Shows if Minikube is running  
**Output explained:**
```
host: Running        ← VM/container is running
kubelet: Running     ← Kubernetes node agent is working
apiserver: Running   ← API server accepting commands
kubeconfig: Configured ← kubectl knows how to connect
```

### `kubectl cluster-info`
**What it does:** Shows cluster connection details  
**Why:** Confirms kubectl can talk to your cluster  
**Output:** URLs of Kubernetes control plane components

### `kubectl get namespaces`
**What it does:** Lists all namespaces in the cluster  
**Namespaces explained:** Virtual clusters within your physical cluster  
**Default namespaces:**
- `default` - Where resources go if you don't specify
- `kube-system` - Kubernetes system components
- `kube-public` - Public resources readable by all
- `kube-node-lease` - Node heartbeat data

**Syntax:** `kubectl get <resource-type>`

### `kubectl get pods`
**What it does:** Lists pods in the current namespace (default)  
**Pod explained:** Smallest deployable unit in Kubernetes - contains one or more containers  
**Common columns:**
- `NAME` - Pod identifier
- `READY` - Containers ready/total
- `STATUS` - Running, Pending, Failed, etc.
- `RESTARTS` - How many times containers restarted
- `AGE` - How long pod has been running

---

## Part 2: Deployment Commands

### `chmod +x deploy.sh`
**What it does:** Makes the shell script executable (Linux/Mac only)  
**Why:** Scripts need execute permission to run  
**Not needed on Windows**

### `kubectl get all -n k8s-lab`
**What it does:** Shows ALL resources in the k8s-lab namespace  
**Breaking it down:**
- `get` - Retrieve resources
- `all` - Pods, services, deployments, replicasets
- `-n k8s-lab` - In the k8s-lab namespace

**💡 This is your "big picture" command!**

---

## Part 3: Namespace Commands

### `kubectl get namespaces` (or `kubectl get ns`)
**What it does:** Lists all namespaces  
**Shorthand:** `ns` instead of `namespaces`  
**Why namespaces matter:**
- Isolate resources between teams/projects
- Apply different policies per namespace
- Organize resources logically
- Like folders for your Kubernetes resources

### `kubectl get configmaps -n k8s-lab`
**What it does:** Lists ConfigMaps in k8s-lab namespace  
**ConfigMap explained:** Stores non-sensitive configuration data  
**Use cases:** Database URLs, feature flags, environment configs

### `kubectl get secrets -n k8s-lab`
**What it does:** Lists Secrets in k8s-lab namespace  
**Secret explained:** Stores sensitive data (passwords, tokens, keys)  
**Important:** Base64 encoded, NOT encrypted by default!

---

## Part 4: Pod Commands

### `kubectl get pods -n k8s-lab`
**What it does:** Lists all pods in k8s-lab namespace  
**Common statuses:**
- `Running` - Pod is running normally
- `Pending` - Waiting to be scheduled
- `ContainerCreating` - Pulling image/starting
- `CrashLoopBackOff` - Container keeps failing
- `Completed` - Finished successfully
- `Error` - Failed to run

### `kubectl describe pod <pod-name> -n k8s-lab`
**What it does:** Shows detailed information about a specific pod  
**Information includes:**
- **Metadata:** Name, namespace, labels
- **Status:** Phase, conditions, IP address
- **Containers:** Images, ports, environment variables
- **Events:** What happened (created, started, pulled image)
- **Resources:** CPU/memory requests and limits

**💡 This is your debugging command #1!**

**How to read events:**
```
Events:
  Type    Reason     Age   Message
  ----    ------     ----  -------
  Normal  Scheduled  2m    Successfully assigned...
  Normal  Pulling    2m    Pulling image...
  Normal  Pulled     1m    Successfully pulled image
  Normal  Created    1m    Created container
  Normal  Started    1m    Started container
```

### `kubectl logs <pod-name> -n k8s-lab`
**What it does:** Shows container logs (stdout/stderr)  
**Why it's important:** See what your application is doing/saying  
**Useful flags:**
- `-f` or `--follow` - Stream logs in real-time
- `--tail=50` - Show only last 50 lines
- `--since=1h` - Logs from last hour
- `-c <container>` - Specific container (if pod has multiple)

**Example:**
```bash
kubectl logs flask-app-xyz -n k8s-lab -f --tail=20
```

### `kubectl exec -it <pod-name> -n k8s-lab -- /bin/sh`
**What it does:** Opens an interactive shell inside the container  
**Breaking it down:**
- `exec` - Execute a command
- `-it` - Interactive terminal
- `<pod-name>` - Which pod
- `-n k8s-lab` - In which namespace
- `--` - Separator
- `/bin/sh` - Command to run (shell)

**Use cases:** Debug, inspect files, run commands inside container  
**Exit:** Type `exit` or press Ctrl+D

**Inside the pod, try:**
```bash
ls              # List files
pwd             # Current directory
env             # Environment variables
ps aux          # Running processes
cat /etc/hosts  # View hosts file
```

### `kubectl delete pod <pod-name> -n k8s-lab`
**What it does:** Deletes a pod  
**What happens:** Kubernetes immediately creates a new one!  
**Why:** Deployment ensures desired state (1 replica means 1 pod always)  
**💡 This demonstrates self-healing!**

---

## Part 5: Service Commands

### `kubectl get services -n k8s-lab` (or `kubectl get svc`)
**What it does:** Lists services in the namespace  
**Service explained:** Stable network endpoint for accessing pods  
**Why needed:** Pods are ephemeral (they come and go), services are stable

**Service types:**
- **ClusterIP** (default): Only accessible within cluster
- **NodePort**: Accessible from outside on a specific port
- **LoadBalancer**: Cloud load balancer (not in Minikube)
- **ExternalName**: Maps to DNS name

**Output columns:**
```
NAME                TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)
flask-app-service   NodePort    10.111.1.88   <none>        5000:30080/TCP
postgres-service    ClusterIP   10.110.26.52  <none>        5432/TCP
```

**Understanding ports:**
- `5000:30080/TCP` means:
  - `5000` - Service port (inside cluster)
  - `30080` - NodePort (outside access)
  - `TCP` - Protocol

### `kubectl describe service <service-name> -n k8s-lab`
**What it does:** Detailed service information  
**Key information:**
- **Type:** ClusterIP, NodePort, etc.
- **IP:** Cluster-internal IP address
- **Port:** Port mappings
- **Endpoints:** Which pod IPs are behind this service
- **Selector:** Labels used to find pods

**💡 If endpoints are empty, service isn't connected to any pods!**

### `minikube service <service-name> -n <namespace>`
**What it does:** Opens service in your browser (for NodePort/LoadBalancer)  
**Minikube-specific:** Creates a tunnel to access NodePort services  
**Output:** URL you can use to access the service

**Alternative:** `minikube service <service-name> -n <namespace> --url`  
Gets URL without opening browser

---

## Part 6: Deployment Commands

### `kubectl get deployments -n k8s-lab` (or `kubectl get deploy`)
**What it does:** Lists deployments  
**Deployment explained:** Manages a set of identical pods  
**Responsible for:**
- Desired state (how many replicas)
- Rolling updates
- Rollbacks
- Self-healing (recreating failed pods)

**Output columns:**
```
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
flask-app   1/1     1            1           5m
```
- `READY`: Current/Desired replicas
- `UP-TO-DATE`: Pods updated to latest config
- `AVAILABLE`: Pods passing health checks

### `kubectl describe deployment <name> -n k8s-lab`
**What it does:** Shows deployment details  
**Key information:**
- **Replicas:** Desired, current, ready, available
- **Strategy:** RollingUpdate, Recreate
- **Pod Template:** Container specs, labels
- **Conditions:** Deployment progress status
- **Events:** Changes made to deployment

### `kubectl scale deployment <name> --replicas=N -n k8s-lab`
**What it does:** Changes number of pod replicas  
**Examples:**
```bash
# Scale up to 3 pods
kubectl scale deployment flask-app --replicas=3 -n k8s-lab

# Scale down to 1 pod
kubectl scale deployment flask-app --replicas=1 -n k8s-lab

# Scale to 0 (stops all pods)
kubectl scale deployment flask-app --replicas=0 -n k8s-lab
```

**What happens:**
- **Scaling up:** Kubernetes creates new pods
- **Scaling down:** Kubernetes gracefully terminates pods
- **Self-healing:** If you delete pods, deployment recreates them

**💡 Horizontal scaling in action!**

### `kubectl get pods -n k8s-lab -w`
**What it does:** Watches pods in real-time  
**The `-w` flag:** Watch mode - updates as changes happen  
**Use case:** See pods being created/deleted/restarted live  
**Exit:** Press Ctrl+C

**What you'll see:**
```
NAME                    READY   STATUS    RESTARTS   AGE
flask-app-abc-xyz       1/1     Running   0          10s
flask-app-abc-new       0/1     Pending   0          1s   ← New pod
flask-app-abc-new       0/1     ContainerCreating   0   2s
flask-app-abc-new       1/1     Running   0          5s
flask-app-abc-old       1/1     Terminating  0      30s  ← Old pod
```

---

## Part 7: ConfigMap and Secret Commands

### `kubectl get configmaps -n k8s-lab` (or `kubectl get cm`)
**What it does:** Lists ConfigMaps  
**When to use ConfigMaps:**
- Database connection strings (non-sensitive)
- Application settings
- Feature flags
- Environment-specific configs

### `kubectl describe configmap <name> -n k8s-lab`
**What it does:** Shows ConfigMap contents  
**You'll see:** All key-value pairs stored in it  
**Data is visible in plain text**

### `kubectl get configmap <name> -n k8s-lab -o yaml`
**What it does:** Shows ConfigMap in YAML format  
**The `-o` flag:** Output format
- `-o yaml` - YAML format
- `-o json` - JSON format
- `-o wide` - More columns
- `-o name` - Just names

**Example output:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DB_HOST: "postgres-service"
  DB_PORT: "5432"
```

### `kubectl get secrets -n k8s-lab`
**What it does:** Lists secrets  
**When to use Secrets:**
- Passwords
- API keys/tokens
- TLS certificates
- SSH keys

### `kubectl describe secret <name> -n k8s-lab`
**What it does:** Shows secret metadata (NOT the actual values!)  
**Security:** Values are hidden when describing  
**You'll see:** Keys stored, but not their values

### `kubectl get secret <name> -n k8s-lab -o yaml`
**What it does:** Shows secret in YAML (base64 encoded)  
**Important:** Base64 is encoding, NOT encryption!  
**Anyone with access can decode it**

**Decoding secrets:**
```bash
# Linux/Mac
echo "cG9zdGdyZXMxMjM=" | base64 -d

# Windows PowerShell
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("cG9zdGdyZXMxMjM="))
```

---

## Part 8: Application Testing Commands

### `curl <URL>/health`
**What it does:** HTTP GET request to health endpoint  
**Health checks:** Tell you if application is running properly  
**Response:** Usually JSON with status

### `curl -X POST <URL>/messages -H "Content-Type: application/json" -d '{"message":"text"}'`
**What it does:** HTTP POST request to create data  
**Breaking it down:**
- `-X POST` - HTTP method
- `-H` - Add header
- `-d` - Request body (data)

**Alternative (PowerShell):**
```powershell
Invoke-RestMethod -Uri "<URL>/messages" -Method POST -ContentType "application/json" -Body '{"message":"Hello"}'
```

---

## Part 9: Resource Exploration Commands

### `kubectl get all -n k8s-lab`
**What it does:** Shows pods, services, deployments, replicasets  
**Doesn't include:** ConfigMaps, Secrets, PVCs  
**💡 Your go-to overview command!**

### `kubectl get <resource> <name> -n <namespace> -o yaml`
**What it does:** Shows the complete resource definition  
**Use cases:**
- Understanding how something is configured
- Copying configuration
- Debugging
- Learning Kubernetes YAML

**Example:**
```bash
kubectl get deployment flask-app -n k8s-lab -o yaml
```

### `kubectl get events -n k8s-lab --sort-by='.lastTimestamp'`
**What it does:** Shows cluster events sorted by time  
**Events track:**
- Pod scheduling
- Image pulls
- Container starts/stops
- Errors and warnings
- Volume mounts

**💡 This is your debugging command #2!**

**Event types:**
- `Normal` - Expected activity
- `Warning` - Something might be wrong
- `Error` - Something failed

### `kubectl top nodes`
**What it does:** Shows node CPU/memory usage  
**Requires:** metrics-server (may not be installed)  
**Use case:** See resource consumption

### `kubectl top pods -n k8s-lab`
**What it does:** Shows pod CPU/memory usage  
**Use case:** Identify resource-hungry pods

---

## Part 10: Troubleshooting Commands

### Debug Workflow:
```
1. kubectl get pods -n k8s-lab              ← See pod status
2. kubectl describe pod <name> -n k8s-lab   ← Check events/config
3. kubectl logs <name> -n k8s-lab           ← Read application logs
4. kubectl get events -n k8s-lab            ← Check cluster events
5. kubectl exec -it <name> -n k8s-lab -- sh ← Get inside container
```

### Common Issues and Commands:

**Pod stuck in Pending:**
```bash
kubectl describe pod <name> -n k8s-lab
# Look for: Insufficient resources, image pull errors
```

**Pod in CrashLoopBackOff:**
```bash
kubectl logs <name> -n k8s-lab
# Check application logs for errors
```

**Can't access service:**
```bash
kubectl describe service <name> -n k8s-lab
# Check if Endpoints field has IPs
```

---

## Part 11: Cleanup Commands

### `kubectl delete namespace <name>`
**What it does:** Deletes namespace and ALL resources inside it  
**Cascade effect:** Pods, services, deployments, everything!  
**Use with caution:** No undo!  
**💡 Fast way to clean up everything**

### `kubectl delete -f <file.yaml>`
**What it does:** Deletes resources defined in a file  
**Opposite of:** `kubectl apply -f <file.yaml>`

### `kubectl delete pod <name> -n <namespace>`
**What it does:** Deletes a specific pod  
**Remember:** Deployment will recreate it!

---

## Essential Flags Reference

### Common Flags:
- `-n <namespace>` - Specify namespace
- `-o yaml` - Output in YAML
- `-o json` - Output in JSON
- `-o wide` - Show more columns
- `-w` or `--watch` - Watch for changes
- `-f` or `--follow` - Follow logs
- `--all-namespaces` or `-A` - All namespaces
- `--help` - Show help

### Examples:
```bash
# All pods in all namespaces
kubectl get pods --all-namespaces

# Or shorter:
kubectl get pods -A

# Watch pods in all namespaces
kubectl get pods -A -w

# Pod YAML
kubectl get pod <name> -n <namespace> -o yaml

# Help for any command
kubectl get --help
kubectl logs --help
```

---

## Resource Type Shortcuts

| Full Name | Shortcut |
|-----------|----------|
| pods | po |
| services | svc |
| deployments | deploy |
| replicasets | rs |
| namespaces | ns |
| configmaps | cm |
| persistentvolumes | pv |
| persistentvolumeclaims | pvc |

**Examples:**
```bash
kubectl get po -n k8s-lab
kubectl get svc -n k8s-lab
kubectl get deploy -n k8s-lab
```

---

## Quick Command Patterns

### View Resources:
```bash
kubectl get <resource>                    # In default namespace
kubectl get <resource> -n <namespace>     # In specific namespace
kubectl get <resource> -A                 # In all namespaces
kubectl get <resource> -o wide            # More details
kubectl get <resource> -o yaml            # YAML output
```

### Describe (Details):
```bash
kubectl describe <resource> <name> -n <namespace>
```

### Logs:
```bash
kubectl logs <pod> -n <namespace>         # View logs
kubectl logs <pod> -n <namespace> -f      # Follow logs
kubectl logs <pod> -n <namespace> --tail=50  # Last 50 lines
```

### Execute Commands:
```bash
kubectl exec <pod> -n <namespace> -- <command>        # Run command
kubectl exec -it <pod> -n <namespace> -- /bin/sh      # Interactive shell
```

### Apply/Delete:
```bash
kubectl apply -f <file>          # Create/update resources
kubectl delete -f <file>         # Delete resources
kubectl delete <resource> <name> # Delete specific resource
```

---

## 💡 Pro Tips

1. **Use tab completion:** 
   - `kubectl get po<TAB>` → `kubectl get pods`
   - Most shells support this

2. **Alias for speed:**
   ```bash
   alias k=kubectl
   alias kgp='kubectl get pods'
   alias kgs='kubectl get services'
   ```

3. **Use `-o wide` for more info:**
   ```bash
   kubectl get pods -o wide -n k8s-lab
   # Shows IP addresses and nodes
   ```

4. **Always specify namespace:**
   - Prevents confusion
   - `-n k8s-lab` becomes muscle memory

5. **Use describe for debugging:**
   - First step when something's wrong
   - Events section is gold!

6. **Watch in separate terminal:**
   ```bash
   kubectl get pods -n k8s-lab -w
   # Keep this running while you work
   ```

---

## Learning Path

### Beginner (You are here!):
- ✅ `kubectl get` - Viewing resources
- ✅ `kubectl describe` - Details
- ✅ `kubectl logs` - Application logs
- ✅ `kubectl exec` - Getting inside containers

### Intermediate (Next steps):
- `kubectl edit` - Edit resources directly
- `kubectl patch` - Update specific fields
- `kubectl port-forward` - Local port forwarding
- `kubectl cp` - Copy files to/from pods

### Advanced (Future):
- `kubectl apply -f` - Deploy from files
- `kubectl rollout` - Manage rollouts
- `kubectl label` - Manage labels
- `kubectl annotate` - Manage annotations

---

**Remember:** The best way to learn is by doing! Try each command, see what happens, and don't be afraid to experiment! 🚀
