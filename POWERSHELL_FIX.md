# PowerShell Execution Policy Fix

## Problem

You're seeing this error when trying to run `deploy.ps1`:
```
File cannot be loaded because running scripts is disabled on this system.
```

This is a Windows security feature that blocks PowerShell scripts by default.

## Solutions

### Option 1: Use Batch Files Instead (Easiest)

We've created `.bat` versions that work without any policy changes:

```cmd
deploy.bat
```

**Cleanup:**
```cmd
cleanup.bat
```

These work exactly the same as the PowerShell scripts!

---

### Option 2: Bypass Policy for One Command

Run the PowerShell script with bypass flag:

```powershell
PowerShell -ExecutionPolicy Bypass -File .\deploy.ps1
```

**Cleanup:**
```powershell
PowerShell -ExecutionPolicy Bypass -File .\cleanup.ps1
```

---

### Option 3: Change Execution Policy Temporarily

Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then you can run:
```powershell
.\deploy.ps1
```

**To revert later:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope CurrentUser
```

---

### Option 4: Unblock the Specific File

Right-click on `deploy.ps1` → Properties → Check "Unblock" → OK

Then run:
```powershell
.\deploy.ps1
```

---

### Option 5: Run Commands Manually

If none of the above work, you can run the commands manually:

#### 1. Check Minikube
```powershell
minikube status
```

#### 2. Configure Docker Environment
```powershell
& minikube -p minikube docker-env --shell powershell | Invoke-Expression
```

#### 3. Build Docker Image
```powershell
cd app
docker build -t flask-k8s-app:latest .
cd ..
```

#### 4. Deploy to Kubernetes
```powershell
kubectl apply -f k8s-manifests/01-namespace.yaml
kubectl apply -f k8s-manifests/02-configmap.yaml
kubectl apply -f k8s-manifests/03-secret.yaml
kubectl apply -f k8s-manifests/04-postgres-deployment.yaml
kubectl apply -f k8s-manifests/05-postgres-service.yaml
kubectl apply -f k8s-manifests/06-app-deployment.yaml
kubectl apply -f k8s-manifests/07-app-service.yaml
```

#### 5. Wait for Pods
```powershell
kubectl wait --for=condition=ready pod -l app=postgres -n k8s-lab --timeout=120s
kubectl wait --for=condition=ready pod -l app=flask-app -n k8s-lab --timeout=120s
```

#### 6. Access Application
```powershell
minikube service flask-app-service -n k8s-lab
```

---

## Recommended Solution for Students

**For Windows users, use the `.bat` files:**
- ✅ No admin rights needed
- ✅ No policy changes required
- ✅ Works on all Windows versions
- ✅ Same functionality as `.ps1` files

**Commands:**
```cmd
deploy.bat      # Deploy the lab
cleanup.bat     # Clean up resources
```

---

## For Instructors

When distributing the lab to students, mention:

1. **Windows users**: Use `deploy.bat` and `cleanup.bat`
2. **Linux/Mac users**: Use `deploy.sh` and `cleanup.sh`
3. Alternative: Run commands manually (see Option 5 above)

This avoids any PowerShell execution policy issues in classroom environments.
