# GitHub Repository Setup Guide

## Setting Up Your Repository

### Step 1: Replace README.md

The current `README.md` is a simple quick-start guide. For GitHub, use the more detailed version:

```bash
# Backup current README
mv README.md README_SIMPLE.md

# Use the GitHub README
mv README_GITHUB.md README.md
```

Or on Windows:
```cmd
ren README.md README_SIMPLE.md
ren README_GITHUB.md README.md
```

### Step 2: Initialize Git Repository

```bash
cd kubernetes-101-lab
git init
git add .
git commit -m "Initial commit: Kubernetes 101 Lab"
```

### Step 3: Create GitHub Repository

1. Go to [GitHub](https://github.com)
2. Click "New Repository"
3. Name it: `kubernetes-101-lab`
4. Description: "Interactive Kubernetes 101 hands-on lab for beginners"
5. Choose: Public (for students to access)
6. **DO NOT** initialize with README (we already have one)
7. Click "Create repository"

### Step 4: Push to GitHub

```bash
git remote add origin https://github.com/YOUR-USERNAME/kubernetes-101-lab.git
git branch -M main
git push -u origin main
```

### Step 5: Update the README

Edit `README.md` and replace:
```
git clone https://github.com/YOUR-USERNAME/kubernetes-101-lab.git
```

with your actual GitHub username.

### Step 6: Add Topics (Optional)

On your GitHub repository page:
1. Click "⚙️ Settings" (or the gear icon near About)
2. Add topics:
   - `kubernetes`
   - `minikube`
   - `docker`
   - `tutorial`
   - `education`
   - `lab`
   - `hands-on`
   - `beginner-friendly`

### Step 7: Configure Repository Settings

#### Enable Issues
- Settings → Features → Check "Issues"
- Students can report problems here

#### Add Description
In "About" section:
- Description: "Interactive Kubernetes 101 hands-on lab - Deploy a Flask + PostgreSQL app on Minikube"
- Website: (optional - your course website)
- Topics: Add the topics listed above

### Step 8: Create Releases (Optional)

Tag a release for easy downloading:

```bash
git tag -a v1.0 -m "Version 1.0 - Initial Release"
git push origin v1.0
```

On GitHub:
1. Go to "Releases"
2. Click "Create a new release"
3. Choose tag: v1.0
4. Title: "Kubernetes 101 Lab v1.0"
5. Description: Brief summary of the lab
6. Click "Publish release"

## Sharing with Students

### Option 1: Clone via HTTPS
```bash
git clone https://github.com/YOUR-USERNAME/kubernetes-101-lab.git
cd kubernetes-101-lab
```

### Option 2: Download ZIP
1. Go to your repository
2. Click "Code" → "Download ZIP"
3. Extract and open terminal in that folder

### Option 3: Use GitHub Classroom (for courses)
- Set up GitHub Classroom
- Create an assignment from your repository
- Students get their own copy automatically

## Student Instructions

Add this to your course materials:

```markdown
### Accessing the Lab

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/kubernetes-101-lab.git
   cd kubernetes-101-lab
   ```

2. **Start Minikube:**
   ```bash
   minikube start
   ```

3. **Deploy:**
   - Windows: `deploy.bat`
   - Linux/Mac: `./deploy.sh`

4. **Follow the lab guide:**
   - Open `LAB_GUIDE.md` and follow the instructions
   - Use `CHEAT_SHEET.md` for command reference
```

## Files to Share

Students need these files:
- ✅ All `.md` documentation files
- ✅ `app/` directory with application code
- ✅ `k8s-manifests/` directory with YAML files
- ✅ Deployment scripts (`.bat` and `.sh`)
- ✅ `.gitignore` (for students who fork)

## Optional: Add License

Create `LICENSE` file:

```bash
# MIT License template
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2026 [Your Name/Institution]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
```

## Repository Maintenance

### Updating the Repository

When you make changes:

```bash
git add .
git commit -m "Description of changes"
git push
```

### Creating Branches for Experiments

```bash
# Create a development branch
git checkout -b dev
# Make changes
git add .
git commit -m "Experimental feature"
git push -u origin dev
```

### Handling Student Issues

When students report issues:
1. Check GitHub Issues tab
2. Reproduce the problem
3. Fix and commit
4. Reference the issue in commit: `git commit -m "Fix issue #1: ..."`

## Example Repository Structure on GitHub

```
YOUR-USERNAME/kubernetes-101-lab
│
├── 📄 README.md (GitHub version with badges)
├── 📄 LICENSE
├── 📄 .gitignore
│
├── 📁 app/
├── 📁 k8s-manifests/
│
├── 📖 Documentation
│   ├── LAB_GUIDE.md
│   ├── INSTRUCTOR_GUIDE.md
│   ├── CHEAT_SHEET.md
│   └── ...
│
└── 🔧 Scripts
    ├── deploy.bat
    ├── deploy.sh
    ├── cleanup.bat
    └── cleanup.sh
```

## GitHub Features to Enable

### 1. GitHub Pages (Optional)
- Host the LAB_GUIDE.md as a website
- Settings → Pages → Source: main branch → /docs folder

### 2. GitHub Actions (Future Enhancement)
- Automate testing
- Validate YAML files
- Check for broken links

### 3. Discussions (Optional)
- Enable for Q&A
- Students can help each other
- Settings → Features → Check "Discussions"

## Sample Course Announcement

```
📢 Kubernetes 101 Lab is now available!

Access the lab materials at:
https://github.com/YOUR-USERNAME/kubernetes-101-lab

This hands-on lab includes:
✅ Flask + PostgreSQL application
✅ Step-by-step instructions
✅ Automated deployment scripts
✅ 60-90 minute interactive exercises

Get started:
1. Clone the repository
2. Run deploy.bat (Windows) or deploy.sh (Linux/Mac)
3. Follow LAB_GUIDE.md

See you in the lab! 🚀
```

## Verification Checklist

Before sharing with students:

- [ ] README.md has your actual GitHub username
- [ ] Repository is set to Public
- [ ] All files are committed and pushed
- [ ] `.gitignore` is working (no unwanted files)
- [ ] Scripts work when cloned to a fresh location
- [ ] Documentation links work
- [ ] Topics/tags are added
- [ ] Description is set
- [ ] License is added (if required)

---

**You're all set!** Students can now clone your repository from any location and the scripts will work perfectly! 🎉
