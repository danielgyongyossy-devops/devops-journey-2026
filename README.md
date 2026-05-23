# Cloud-Native DevOps Journey 2026

A FastAPI app deployed the cloud-native way: Docker, Terraform, Kubernetes, Helm, and GitHub Actions.

It started on GCP, and now it also deploys to AWS. The same app image gets built in CI and shipped to both GKE and EKS without long-lived cloud keys sitting in GitHub.

## What It Runs On

- FastAPI app on Python 3.11
- Docker container image
- Terraform for cloud infrastructure
- GCP: VPC, GKE, Artifact Registry
- AWS: VPC, EKS, ECR
- Helm for Kubernetes deployment
- Kubernetes HPA (Horizontal Pod Autoscaler
- GitHub Actions for CI/CD
- OIDC-based auth for both clouds
- Prometheus and Grafana for monitoring

## CI/CD

The main workflow is:

```text
.github/workflows/ci-cd-multicloud.yml
```

On pull requests, it runs the tests.

On pushes to `main`, it:

1. Runs the FastAPI tests.
2. Builds the Docker image.
3. Pushes the image to Google Artifact Registry.
4. Pushes the image to Amazon ECR.
5. Deploys to GKE with Helm.
6. Deploys to EKS with Helm.
7. Applies Kubernetes Horizontal Pod Autoscaling (HPA) using CPU utilization targets.

Both cloud deploys use GitHub OIDC, so there are no service account JSON files or AWS access keys stored in the repo.

Required GitHub Actions secrets:

```text
GCP_PROJECT_ID
GCP_WIF_PROVIDER
GCP_WIF_SERVICE_ACCOUNT
AWS_ROLE_ARN
```

## Local App

```bash
cd app
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload
```

The app exposes:

```text
/health
/api/hello
```

## Terraform

GCP infrastructure lives here:

```text
infra/terraform/gcp
```

AWS infrastructure lives here:

```text
infra/terraform/aws
```

Typical flow:

```bash
terraform init
terraform fmt
terraform plan
terraform apply
```

For AWS, after apply:

```bash
terraform output -raw github_role_arn
```

That value goes into the GitHub secret named `AWS_ROLE_ARN`.

## Project Layout

```text
app/                  FastAPI app and Dockerfile
tests/                pytest tests
charts/               Helm chart used by both clouds
k8s/                  raw Kubernetes/Kustomize manifests
infra/terraform/gcp/  GCP infrastructure
infra/terraform/aws/  AWS infrastructure
monitoring/           Prometheus/Grafana values and notes
.github/workflows/    GitHub Actions workflows only
```

## Monitoring

The monitoring stack uses Prometheus and Grafana:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f monitoring/kube-prometheus-stack-values.yaml
```

Access Grafana:

```bash
kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80
```

Then open:

```text
http://localhost:3000
```

## Current Status

- [x] GCP infrastructure with Terraform
- [x] GKE deployment with GitHub Actions
- [x] AWS infrastructure with Terraform
- [x] EKS deployment with GitHub Actions
- [x] Helm-based app deployment
- [x] Kubernetes HPA autoscaling
- [x] OIDC auth for GCP and AWS
- [x] Prometheus/Grafana monitoring
      

Next things worth exploring:

- remote Terraform state for AWS
- tighter IAM policies
- app-level metrics dashboard
- multi-cloud traffic routing or failover
