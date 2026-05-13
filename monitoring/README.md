# Monitoring (Grafana + Prometheus) - kube-prometheus-stack

This repo deploys **Grafana** and **Prometheus** using the Helm chart **kube-prometheus-stack**.
Your app exposes Prometheus metrics at **GET /metrics** and includes a **ServiceMonitor** so Prometheus can scrape it.

## 1) Prereqs
- `helm`
- `kubectl`
- The cluster is reachable (EKS / GKE)

## 2) Install monitoring (per cluster)
```bash
kubectl create namespace monitoring || true
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring -f monitoring/kube-prometheus-stack-values.yaml
```

## 3) Access Grafana (internal-only)
Use port-forward:
```bash
kubectl -n monitoring port-forward svc/kube-prometheus-stack-grafana 3000:80
```

Open:
- http://localhost:3000

Login:
- user: `admin`
- password: `admin` (see `monitoring/kube-prometheus-stack-values.yaml`)

## 4) Verify your app is scraped
1. In Grafana, open Prometheus data source / Explore.
2. Query for metrics from your app. If you just want to confirm scraping:
   - query for HTTP request metrics and/or instrumentator metrics
3. Confirm Prometheus has a target for `cloud-native-app`.

Notes:
- The app `ServiceMonitor` is deployed  kustomize manifests from:
  - `App/Kubernetes/base/service-monitor.yaml`
