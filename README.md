Cloud-Native DevOps Journey 2026
A production-grade, multi-cloud ready FastAPI application. This project demonstrates a complete DevOps lifecycle: from local development and containerization to Infrastructure-as-Code (IaC) and Automated GitOps pipelines.

🏗️ Architecture Overview
- Application: FastAPI (Python 3.11+)

- Infrastructure: Google Cloud Platform (VPC, Subnets, GKE, Artifact Registry)

- IaC: Terraform (Modularized, GCS Backend)

- CI/CD: GitHub Actions with Workload Identity Federation (Keyless Auth)

- Observability: Prometheus & Grafana (Helm-based)

🛠️ Tech Stack & Features
- FastAPI: High-performance web framework with /health and /api/hello endpoints.

- Terraform: Fully automated GCP infrastructure provisioning.

- Docker: Multi-stage builds for optimized image sizes.

- Kubernetes (GKE): Orchestrated deployment with LoadBalancer services and autoscaling.

- Security: Keyless authentication via OIDC/Workload Identity Federation.

- Monitoring: Custom ServiceMonitor for automated metric scraping.

🚀 Getting Started
1. Infrastructure Provisioning (Terraform)
Provision  GCP environment before deploying the app.

- Bash
- cd Terraform/gcp
- terraform init
- terraform plan
- terraform apply
2. Local Development
- Bash
- cd App
- python -m venv venv
- source venv/bin/activate
- pip install -r requirements.txt
- uvicorn main:app --reload
3. Manual Container Build
- Bash
- docker build -t cloud-native-app ./App
- docker run -p 8000:8000 cloud-native-app
🤖 CI/CD Pipeline
The project uses a  GitHub Actions workflow (.github/workflows/ci-cd gcp.yml):

- Test: Runs pytest on every Pull Request.

- Infra: (Optional) Validates Terraform plans.

- Build: Packages the Docker image and pushes to Google Artifact Registry.

- Deploy: Updates the GKE cluster using kubectl and Kustomize.

[!IMPORTANT]

Auth: This project uses Workload Identity Federation. No Service Account JSON keys are stored in GitHub Secrets, significantly improving security.

📈 Monitoring & Observability
The app is "observability-aware" and exposes metrics for Prometheus.

- Deploy the Monitoring Stack
- Bash
- helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
- helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
-   --namespace monitoring --create-namespace \
-   -f monitoring/values.yaml
- Access Dashboards
- Bash
- kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80
- URL: http://localhost:3000 (User: admin / Pass: prom-operator)

🗺️ Roadmap & Multi-Cloud
[x] GCP Infrastructure via Terraform

[x] GKE Deployment with GitHub Actions

[x] Prometheus/Grafana Integration

[ ] Next Step: AWS EKS Deployment (Terraform modules in progress)

[ ] Next Step: Cross-cloud Load Balancing with Anthos or Istio
