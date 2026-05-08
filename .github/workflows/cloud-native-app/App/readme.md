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

Test the endpoints:
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

The project includes a GitHub Actions workflow (`.github/workflows/ci-cd.yml`) that:
- Runs tests on push/PR
- Builds and pushes Docker image to GCR
- Deploys to GKE

### Setup Secrets

Add these to your GitHub repo secrets:
- `GCP_PROJECT_ID`: Your Google Cloud Project ID
- `GCP_SA_KEY`: JSON key for a service account with GKE and GCR permissions

## Environment Variables

- `ENV`: Set to "prod" in production (defaults to "dev")

## Contributing

1. Fork the repo
2. Create a feature branch
3. Make changes and add tests
4. Submit a PR

## License

MIT