resource "cloud_native_app" {
  name       = "cloud-native-app"
  repository = null
  chart      = "./charts/cloud-native-app"
  namespace  = "default"
  wait       = true

  
  values = [
    yamlencode({
      image = {
        repository = "${var.region}-docker.pkg.dev/${var.project_id}/${var.registry_id}/cloud-native-app"
        tag        = "latest"
      }
      service = {
        type = "LoadBalancer"
        port = 80
        targetPort = 8000
      }
  serviceAccount = {
        create = false
        name   = ""
      }
      
      ingress = {
        enabled = false
      }
      httpRoute = {
        enabled = false
      }

      autoscaling = {
        enabled = false
      }

livenessProbe = {
        httpGet = {
          path = "/health"
          port = 8000
        }
initialDelaySeconds = 20
        periodSeconds      = 10
      }
      readinessProbe = {
        httpGet = {
          path = "/health"
          port = 8000
        }
initialDelaySeconds = 15
        periodSeconds      = 5
      }
    })
  ]

  depends_on = [module.gke, module.network]
}
