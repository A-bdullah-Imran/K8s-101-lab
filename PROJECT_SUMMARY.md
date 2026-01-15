# Kubernetes 101 Lab - Project Summary

## Overview

This is a complete, production-ready Kubernetes 101 practical lab designed for students who have just completed a Kubernetes theory course. The lab provides hands-on experience with Minikube, deploying a real two-tier application (Flask + PostgreSQL).

## What's Included

### 📁 Application Files (`app/`)

1. **app.py** - Flask REST API application
   - Message management endpoints
   - Database connectivity with retry logic
   - Health check endpoint
   - Environment variable configuration

2. **Dockerfile** - Container image definition
   - Python 3.11 slim base image
   - Application setup and dependencies

3. **requirements.txt** - Python dependencies
   - Flask 3.0.0
   - psycopg2-binary 2.9.9

### 📁 Kubernetes Manifests (`k8s-manifests/`)

1. **01-namespace.yaml** - Namespace for resource isolation
2. **02-configmap.yaml** - Database configuration (non-sensitive)
3. **03-secret.yaml** - Database password (base64 encoded)
4. **04-postgres-deployment.yaml** - PostgreSQL database deployment
5. **05-postgres-service.yaml** - PostgreSQL service (ClusterIP)
6. **06-app-deployment.yaml** - Flask application deployment
7. **07-app-service.yaml** - Flask service (NodePort)

### 📄 Documentation Files

1. **README.md** - Quick start guide and project overview
2. **LAB_GUIDE.md** - Comprehensive step-by-step student lab instructions
3. **INSTRUCTOR_GUIDE.md** - Teaching notes, answer keys, and troubleshooting
4. **LAB_MANUAL_PRINTABLE.md** - Print-friendly workbook format
5. **CHEAT_SHEET.md** - Quick reference for kubectl and Minikube commands
6. **CONVERSION_INSTRUCTIONS.md** - Guide for converting to DOCX format
7. **PROJECT_SUMMARY.md** - This file

### 🔧 Deployment Scripts

**Windows:**
- **deploy.ps1** - Automated deployment script
- **cleanup.ps1** - Resource cleanup script

**Linux/Mac:**
- **deploy.sh** - Automated deployment script
- **cleanup.sh** - Resource cleanup script

## Lab Features

### ✨ Interactive Learning

- **12 Hands-on Sections** covering all core Kubernetes concepts
- **Fill-in-the-blank Questions** for active learning
- **Self-Healing Demo** to observe Kubernetes automation
- **Scaling Exercises** to understand deployments
- **Troubleshooting Practice** with intentional failures
- **Bonus Challenges** for advanced students

### 🎯 Learning Objectives

Students will learn:
- Pod management and inspection
- Service types and networking
- Deployment and scaling
- ConfigMaps and Secrets
- Namespace usage
- kubectl commands
- Troubleshooting techniques
- Kubernetes architecture concepts

### 🏗️ Application Architecture

```
┌─────────────────────────────────────┐
│         Minikube Cluster            │
│                                     │
│  ┌──────────────────────────────┐  │
│  │      k8s-lab Namespace       │  │
│  │                              │  │
│  │  ┌──────────────────────┐   │  │
│  │  │   Flask App Pod      │   │  │
│  │  │   (flask-k8s-app)    │   │  │
│  │  └──────────┬───────────┘   │  │
│  │             │                │  │
│  │  ┌──────────▼───────────┐   │  │
│  │  │  flask-app-service   │   │  │
│  │  │  (NodePort: 30080)   │   │  │
│  │  └──────────────────────┘   │  │
│  │                              │  │
│  │  ┌──────────────────────┐   │  │
│  │  │   PostgreSQL Pod     │   │  │
│  │  │   (postgres:15)      │   │  │
│  │  └──────────┬───────────┘   │  │
│  │             │                │  │
│  │  ┌──────────▼───────────┐   │  │
│  │  │  postgres-service    │   │  │
│  │  │  (ClusterIP: 5432)   │   │  │
│  │  └──────────────────────┘   │  │
│  │                              │  │
│  │  ConfigMap: app-config       │  │
│  │  Secret: app-secret          │  │
│  └──────────────────────────────┘  │
└─────────────────────────────────────┘
```

## Key Kubernetes Concepts Covered

### Core Resources
- ✅ Pods - Smallest deployable units
- ✅ Deployments - Declarative updates for Pods and ReplicaSets
- ✅ Services - Network abstraction for accessing Pods
- ✅ Namespaces - Virtual clusters for resource isolation
- ✅ ConfigMaps - Configuration data storage
- ✅ Secrets - Sensitive data storage

### Operations
- ✅ Scaling - Horizontal pod scaling
- ✅ Self-Healing - Automatic pod recovery
- ✅ Service Discovery - DNS-based service names
- ✅ Health Checks - Liveness and readiness probes
- ✅ Resource Management - CPU and memory limits

### kubectl Commands
- `kubectl get` - List resources
- `kubectl describe` - Detailed information
- `kubectl logs` - View container logs
- `kubectl exec` - Execute commands in containers
- `kubectl scale` - Scale deployments
- `kubectl delete` - Remove resources
- `kubectl apply` - Apply configuration

## Lab Timeline

| Section | Duration | Activity |
|---------|----------|----------|
| Part 1: Setup | 10 min | Environment verification |
| Part 2: Deployment | 15 min | Deploy application |
| Part 3: Namespaces | 10 min | Explore namespaces |
| Part 4: Pods | 15 min | Work with pods |
| Part 5: Services | 10 min | Understand networking |
| Part 6: Deployments | 15 min | Scaling and self-healing |
| Part 7: Config/Secrets | 10 min | Configuration management |
| Part 8: Testing | 10 min | Test application functionality |
| Part 9: Resources | 10 min | Explore resource definitions |
| Part 10: Troubleshooting | 10 min | Practice debugging |
| Part 11: Cleanup | 5 min | Remove resources |
| Part 12: Bonus | Optional | Advanced challenges |

**Total:** 60-90 minutes (core) + 30 minutes (bonus)

## Quick Start for Instructors

### Before Class

1. **Test the lab yourself**
   ```bash
   cd kubernetes-101-lab
   .\deploy.ps1  # or ./deploy.sh on Linux/Mac
   ```

2. **Review instructor guide**
   - Read INSTRUCTOR_GUIDE.md
   - Note common issues and solutions

3. **Prepare environment**
   - Ensure students have Minikube, kubectl, Docker installed
   - Share environment check script

### During Class

1. **Introduction (5 min)**
   - Explain lab objectives
   - Review architecture diagram
   - Set expectations

2. **Guided Walkthrough (30-45 min)**
   - Walk through Parts 1-6 together
   - Let students explore at their own pace

3. **Independent Work (30-45 min)**
   - Students complete Parts 7-11
   - Circulate to help with issues

4. **Wrap-up (10 min)**
   - Discuss key takeaways
   - Answer questions
   - Preview next steps

### After Class

1. **Collect feedback**
   - Student reflections from Part 15
   - Note difficulties for improvement

2. **Grade submissions** (if applicable)
   - Check completed workbooks
   - Review reflection questions

## Converting to DOCX

For printable student workbooks:

```bash
# Install Pandoc first
# Windows: choco install pandoc
# Mac: brew install pandoc
# Linux: sudo apt-get install pandoc

# Convert lab manual
pandoc LAB_MANUAL_PRINTABLE.md -o LAB_MANUAL.docx --toc

# Convert instructor guide
pandoc INSTRUCTOR_GUIDE.md -o INSTRUCTOR_GUIDE.docx --toc

# Convert cheat sheet
pandoc CHEAT_SHEET.md -o CHEAT_SHEET.docx
```

See CONVERSION_INSTRUCTIONS.md for detailed instructions.

## Customization Options

### Easy Modifications

1. **Change Application**
   - Replace Flask app with your own
   - Update Dockerfile and manifests

2. **Add More Services**
   - Add Redis, RabbitMQ, etc.
   - Create additional manifest files

3. **Adjust Difficulty**
   - Remove some guided steps
   - Add more complex challenges

4. **Change Resource Limits**
   - Edit deployment manifests
   - Adjust CPU/memory values

### Advanced Modifications

1. **Add Persistent Storage**
   - Create PersistentVolume and PersistentVolumeClaim
   - Update postgres deployment

2. **Add Ingress**
   - Enable Minikube ingress addon
   - Create Ingress resource

3. **Add Monitoring**
   - Deploy Prometheus/Grafana
   - Add monitoring exercises

4. **Multi-namespace Setup**
   - Deploy to dev/staging/prod namespaces
   - Practice namespace isolation

## Troubleshooting Guide

### Common Student Issues

| Issue | Quick Fix |
|-------|-----------|
| Minikube won't start | Check virtualization enabled |
| Pods pending | Increase Minikube resources |
| Image pull error | Run deploy script again |
| Can't access service | Use `minikube service` command |
| Database errors | Wait for postgres to be ready |

See INSTRUCTOR_GUIDE.md for detailed troubleshooting.

## File Checklist

Use this checklist when distributing to students:

### Required Files
- [ ] README.md
- [ ] LAB_GUIDE.md or LAB_MANUAL.docx
- [ ] CHEAT_SHEET.md
- [ ] app/ directory (all files)
- [ ] k8s-manifests/ directory (all files)
- [ ] deploy.ps1 (Windows) or deploy.sh (Linux/Mac)
- [ ] cleanup.ps1 (Windows) or cleanup.sh (Linux/Mac)

### Optional Files
- [ ] INSTRUCTOR_GUIDE.md (for TAs)
- [ ] LAB_MANUAL_PRINTABLE.md
- [ ] CONVERSION_INSTRUCTIONS.md
- [ ] PROJECT_SUMMARY.md

## Distribution Methods

### Method 1: ZIP File
```bash
# Create a zip file for distribution
Compress-Archive -Path kubernetes-101-lab -DestinationPath kubernetes-101-lab.zip
```

### Method 2: Git Repository
```bash
# Initialize git repo
git init
git add .
git commit -m "Initial commit: Kubernetes 101 Lab"
git remote add origin <your-repo-url>
git push -u origin main
```

### Method 3: LMS Upload
- Upload individual files to Canvas, Blackboard, Moodle, etc.
- Organize in folders matching the structure

## Support Resources

### For Students
- LAB_GUIDE.md - Step-by-step instructions
- CHEAT_SHEET.md - Command reference
- README.md - Quick start

### For Instructors
- INSTRUCTOR_GUIDE.md - Teaching notes and answers
- PROJECT_SUMMARY.md - Overview (this file)
- CONVERSION_INSTRUCTIONS.md - DOCX conversion guide

### External Resources
- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Minikube Docs](https://minikube.sigs.k8s.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

## License and Usage

This lab is designed for educational purposes. Feel free to:
- ✅ Use in classroom settings
- ✅ Modify for your curriculum
- ✅ Distribute to students
- ✅ Share with colleagues

Please:
- ⚠️ Give credit where appropriate
- ⚠️ Share improvements with the community
- ⚠️ Don't remove educational content

## Future Enhancements

Potential additions for future versions:
- [ ] Video walkthrough
- [ ] Auto-grading scripts
- [ ] Additional language versions (Java, Go, Node.js)
- [ ] Helm charts version
- [ ] CI/CD pipeline integration
- [ ] Service mesh introduction (Istio/Linkerd)
- [ ] Advanced networking exercises
- [ ] Security best practices module

## Credits

**Created by:** Instructor Team
**Version:** 1.0
**Last Updated:** January 2026
**Kubernetes Version:** 1.28+
**Minikube Version:** 1.30+

## Feedback and Contributions

We welcome feedback and contributions!

**Contact:**
- Report issues via your institution's channels
- Share improvements with your team
- Contribute enhancements to the curriculum

---

## Quick Stats

- **Total Files:** 20+
- **Lines of Documentation:** 3000+
- **Lines of Code:** 500+
- **Lab Duration:** 60-90 minutes
- **Concepts Covered:** 20+
- **kubectl Commands:** 30+
- **Exercises:** 50+

---

**Thank you for using the Kubernetes 101 Lab!**

We hope this provides your students with an engaging, hands-on introduction to Kubernetes. Happy teaching! 🚀

---

## Version History

### v1.0 (January 2026)
- Initial release
- Complete 2-tier application
- 12-part lab guide
- Instructor materials
- Deployment automation
- Windows and Linux support
