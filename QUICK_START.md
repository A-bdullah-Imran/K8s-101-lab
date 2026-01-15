# Quick Start Guide

## For Students Using GitHub

### Step 1: Clone the Repository

```bash
git clone <your-github-repo-url>
cd kubernetes-101-lab
```

Or download ZIP and extract it, then:
```bash
cd kubernetes-101-lab
```

### Step 2: Start Minikube

```bash
minikube start
```

### Step 3: Run the Deploy Script

**Windows:**
```cmd
deploy.bat
```

**Linux/Mac:**
```bash
chmod +x deploy.sh
./deploy.sh
```

### Step 4: Access the Application

```bash
minikube service flask-app-service -n k8s-lab
```

## Important Notes

✅ **Directory Location**: You can clone/download to ANY location on your computer  
✅ **Must Run From Inside**: You MUST be inside the `kubernetes-101-lab` folder when running scripts  
✅ **Relative Paths**: All scripts use relative paths, so they work regardless of where you downloaded the repo

## Example Usage

If you clone to different locations, it works fine:

```bash
# Works from C:\Users\student\kubernetes-101-lab
cd C:\Users\student\kubernetes-101-lab
deploy.bat

# Also works from D:\Projects\kubernetes-101-lab
cd D:\Projects\kubernetes-101-lab
deploy.bat

# Also works from ~/Downloads/kubernetes-101-lab
cd ~/Downloads/kubernetes-101-lab
./deploy.sh
```

**Key Point:** Just make sure you `cd` into the repo folder before running the scripts!

## Cleanup

When you're done:

**Windows:**
```cmd
cleanup.bat
```

**Linux/Mac:**
```bash
./cleanup.sh
```

## Need Help?

- Windows PowerShell issues? See `POWERSHELL_FIX.md`
- Full lab instructions? See `LAB_GUIDE.md`
- Quick commands reference? See `CHEAT_SHEET.md`

---

**Happy Learning!** 🚀
