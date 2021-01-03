resource "kubernetes_service" "tf_k8s_svc_dev" {
  metadata {
    name = "ec-svc-dev"
    namespace = "env-dev"
  }

  spec {
    selector = {
      podname = "ec-app-dev"
    }
    port {
      name = "web80"
      port = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
