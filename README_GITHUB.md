# Kubernetes 101 Lab - Minikube Practical

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28%2B-blue)](https://kubernetes.io/)
[![Minikube](https://img.shields.io/badge/Minikube-1.30%2B-blue)](https://minikube.sigs.k8s.io/)

An interactive, hands-on Kubernetes lab for beginners. Deploy a real two-tier application (Flask + PostgreSQL) on Minikube and learn core Kubernetes concepts through practical exercises.

![Kubernetes Lab](https://img.shields.io/badge/Level-Beginner-green)
![Duration](https://img.shields.io/badge/Duration-60--90%20min-orange)

## 🎯 What You'll Learn

- ☸️ Deploy applications to Kubernetes
- 🐳 Work with Pods, Deployments, Services
- 🔐 Use ConfigMaps and Secrets
- 📦 Manage Namespaces
- 📊 Scale applications
- 🔍 Troubleshoot issues
- 💻 Master kubectl commands

## 📋 Prerequisites

- **Minikube** installed ([Installation Guide](https://minikube.sigs.k8s.io/docs/start/))
- **kubectl** installed ([Installation Guide](https://kubernetes.io/docs/tasks/tools/))
- **Docker** installed ([Installation Guide](https://docs.docker.com/get-docker/))
- Basic understanding of containers and Kubernetes concepts

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/kubernetes-101-lab.git
cd kubernetes-101-lab
```

### 2. Start Minikube

```bash
minikube start
```

### 3. Deploy the Application

**Windows:**
```cmd
deploy.bat
```

**Linux/Mac:**
```bash
chmod +x deploy.sh
./deploy.sh
```

### 4. Access the Application

```bash
minikube service flask-app-service -n k8s-lab
```

## 📚 Lab Structure

```
kubernetes-101-lab/
├── 📖 LAB_GUIDE.md              # Detailed student instructions
├── 👨‍🏫 INSTRUCTOR_GUIDE.md       # Teaching notes & answer keys
├── 📄 CHEAT_SHEET.md            # kubectl command reference
├── 🐍 app/                      # Flask application
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── ☸️  k8s-manifests/           # Kubernetes YAML files
│   ├── 01-namespace.yaml
│   ├── 02-configmap.yaml
│   ├── 03-secret.yaml
│   ├── 04-postgres-deployment.yaml
│   ├── 05-postgres-service.yaml
│   ├── 06-app-deployment.yaml
│   └── 07-app-service.yaml
└── 🔧 Scripts
    ├── deploy.bat               # Windows deployment
    ├── deploy.sh                # Linux/Mac deployment
    ├── cleanup.bat              # Windows cleanup
    └── cleanup.sh               # Linux/Mac cleanup
```

## 🏗️ Application Architecture

```
┌─────────────────────────────────────┐
│         Minikube Cluster            │
│                                     │
│  ┌──────────────────────────────┐  │
│  │      k8s-lab Namespace       │  │
│  │                              │  │
│  │  Flask App ←→ Service        │  │
│  │  (NodePort 30080)            │  │
│  │         ↓                    │  │
│  │  PostgreSQL ←→ Service       │  │
│  │  (ClusterIP 5432)            │  │
│  │                              │  │
│  │  ConfigMap + Secret          │  │
│  └──────────────────────────────┘  │
└─────────────────────────────────────┘
```

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [LAB_GUIDE.md](LAB_GUIDE.md) | Complete step-by-step lab instructions for students |
| [INSTRUCTOR_GUIDE.md](INSTRUCTOR_GUIDE.md) | Teaching notes, answer keys, troubleshooting |
| [CHEAT_SHEET.md](CHEAT_SHEET.md) | Quick reference for kubectl commands |
| [QUICK_START.md](QUICK_START.md) | Fast setup guide for students |
| [POWERSHELL_FIX.md](POWERSHELL_FIX.md) | Windows PowerShell execution policy fixes |

## 🎓 Lab Contents

### Part 1-12: Core Exercises (60-90 minutes)

1. **Environment Setup** - Verify prerequisites
2. **Application Deployment** - Deploy Flask + PostgreSQL
3. **Namespaces** - Understanding resource isolation
4. **Pods** - Working with containers in Kubernetes
5. **Services** - Networking and service discovery
6. **Deployments** - Scaling and self-healing
7. **ConfigMaps & Secrets** - Configuration management
8. **Testing** - Interacting with the application
9. **Resource Exploration** - Understanding YAML manifests
10. **Troubleshooting** - Debugging practice
11. **Cleanup** - Removing resources
12. **Bonus Challenges** - Advanced exercises

## 🛠️ Technologies Used

- **Kubernetes**: Container orchestration
- **Minikube**: Local Kubernetes cluster
- **Docker**: Containerization
- **Flask**: Python web framework
- **PostgreSQL**: Relational database
- **kubectl**: Kubernetes CLI

## 🧪 Testing the Application

Once deployed, test the REST API:

```bash
# Get the URL
URL=$(minikube service flask-app-service -n k8s-lab --url)

# Health check
curl $URL/health

# Create a message
curl -X POST $URL/messages -H "Content-Type: application/json" -d '{"message":"Hello Kubernetes!"}'

# List messages
curl $URL/messages
```

## 🧹 Cleanup

**Windows:**
```cmd
cleanup.bat
```

**Linux/Mac:**
```bash
./cleanup.sh
```

## 🐛 Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| PowerShell execution policy error | Use `deploy.bat` or see [POWERSHELL_FIX.md](POWERSHELL_FIX.md) |
| Minikube not running | Run `minikube start` |
| Pods stuck in Pending | Increase Minikube resources: `minikube start --memory=4096 --cpus=2` |
| Image pull errors | Run the deploy script again |
| Can't access service | Use `minikube service flask-app-service -n k8s-lab` |

## 📊 Lab Statistics

- **Total Files**: 25+
- **Documentation**: 3000+ lines
- **Application Code**: 500+ lines
- **Duration**: 60-90 minutes
- **Concepts Covered**: 20+
- **kubectl Commands**: 30+
- **Exercises**: 50+

## 👥 For Instructors

This lab is designed to be taught after a Kubernetes 101 theory session. It includes:

- ✅ Complete answer keys
- ✅ Teaching notes and tips
- ✅ Common student issues and solutions
- ✅ Suggested timing for each section
- ✅ Discussion questions
- ✅ Extension activities

See [INSTRUCTOR_GUIDE.md](INSTRUCTOR_GUIDE.md) for detailed teaching materials.

## 📄 License

This project is licensed under the MIT License - feel free to use it for educational purposes.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📧 Support

For issues or questions:
- Open an issue in this repository
- Check [POWERSHELL_FIX.md](POWERSHELL_FIX.md) for Windows issues
- Review [INSTRUCTOR_GUIDE.md](INSTRUCTOR_GUIDE.md) for common problems

## 🌟 Acknowledgments

Created for students learning Kubernetes fundamentals through hands-on practice.

---

**Ready to start learning Kubernetes?** Clone this repo and run `deploy.bat` (Windows) or `./deploy.sh` (Linux/Mac)! 🚀

## 📸 Screenshots

*Add screenshots of your deployed application here*

## 🔗 Useful Links

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Docker Documentation](https://docs.docker.com/)

---

Made with ❤️ for Kubernetes learners
