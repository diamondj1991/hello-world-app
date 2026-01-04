# Hello World App (Flask)

A simple, containerized Python web application used to demonstrate CI/CD and GitOps workflows in Kubernetes.

## 🚀 Features
- **Language:** Python 3.11
- **Framework:** Flask
- **Logging:** Structured logging enabled via `logging.INFO` and `PYTHONUNBUFFERED=1` for real-time Kubernetes observability.
- **Containerization:** Multi-stage Docker build for a minimized production image.

## 🛠️ Local Development

### Prerequisites
- Python 3.8+ (Target: 3.11 as defined in Dockerfile)
- Docker

### Running Locally
1. Install dependencies: `pip install -r requirements.txt`
2. From the project root: `flask --app src/app run`
3. Access at: `http://localhost:5000` or `http://127.0.0.1:5000`

### Build and Push (SRE Workflow)
The included `Makefile` automates the build process:
```bash
make build VERSION=v1.0.0
make push VERSION=v1.0.0
```
