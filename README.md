# devops-journey-2026
# Cloud Native App

A simple FastAPI application demonstrating cloud-native development with Docker and Kubernetes deployment to Google Kubernetes Engine (GKE).

## Features

- Health check endpoint (`/health`)
- Hello world endpoint (`/api/hello`)
- Containerized with Docker
- Deployed on Kubernetes with LoadBalancer service
- Automated CI/CD with GitHub Actions
- CI/CD

The project includes a GitHub Actions workflow (`.github/workflows/ci-cd.yml`) that automates:
- Tests on push/PR
- Docker build and push to GCR
- Deployment to GKE
- Auth working
- monitoring functional.
- 

 
 
Next steps in progress:
Terraform usage,
AWS multicloud deployment,

