# Cloud Native App

A simple FastAPI application demonstrating cloud-native development with Docker and Kubernetes deployment to Google Kubernetes Engine (GKE).

## Features

- Health check endpoint (`/health`)
- Hello world endpoint (`/api/hello`)
- Containerized with Docker
- Deployed on Kubernetes with LoadBalancer service
- Automated CI/CD with GitHub Actions

## Prerequisites

- Python 3.11+
- Docker
- Google Cloud SDK (gcloud)
- kubectl
- A Google Cloud Project with GKE enabled

## Local Development

### Setup

1. Clone the repository:
   ```bash
   git clone <your-repo-url>
   cd .github/workflows/cloud-native-app/App
   ```

2. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

### Run Locally

```bash
uvicorn main:app --host 0.0.0.0 --port 8000
```

Testing the endpoints:
- Health: `curl http://localhost:8000/health`
- Hello: `curl http://localhost:8000/api/hello`

### Run Tests

```bash
pytest
```

## Docker

### Build Image

```bash
docker build -t cloud-native-app .
```

### Run Container

```bash
docker run -p 8000:8000 cloud-native-app
```

## Kubernetes Deployment

### Prerequisites

- GKE cluster created
- kubectl configured

### Deploy

1. Tag and push image to GCR:
   ```bash
   docker tag cloud-native-app gcr.io/YOUR_PROJECT_ID/cloud-native-app:latest
   docker push gcr.io/YOUR_PROJECT_ID/cloud-native-app:latest
   ```

2. Update `k8s/deployment.yaml` with your project ID.

3. Apply manifests:
   ```bash
   kubectl apply -f ../k8s/
   ```

4. Get service IP:
   ```bash
   kubectl get services cloud-native-app-service
   ```

## CI/CD

The project includes a GitHub Actions workflow (`.github/workflows/ci-cd.yml`) that automates:
- Tests on push/PR
- Docker build and push to GCR
- Deployment to GKE

**Note**: Automated CI/CD requires Workload Identity Federation setup. On trial Google Cloud accounts with org policies blocking OIDC provider creation, use manual deployment (see below).

## Manual Deployment (For Trial Accounts / Local Setup)

1. **Build Docker image**:
   ```bash
   cd .github/workflows/cloud-native-app/App
   docker build -t cloud-native-app .
   ```

2. **Tag for GCR**:
   ```bash
   docker tag cloud-native-app gcr.io/YOUR_PROJECT_ID/cloud-native-app:latest
   ```

3. **Push to GCR**:
   ```bash
   gcloud auth configure-docker
   docker push gcr.io/YOUR_PROJECT_ID/cloud-native-app:latest
   ```

4. **Connect to GKE cluster**:
   ```bash
   gcloud container clusters get-credentials my-cluster --zone us-central1-a --project YOUR_PROJECT_ID
   ```

5. **Update deployment image** in `k8s/deployment.yaml`:
   ```yaml
   image: gcr.io/YOUR_PROJECT_ID/cloud-native-app:latest
   ```

6. **Deploy to Kubernetes**:
   ```bash
   kubectl apply -f ../k8s/
   ```

7. **Get service IP**:
   ```bash
   kubectl get services cloud-native-app-service
   ```

## Environment Variables

- `ENV`: Set to "prod" in production (defaults to "dev")

