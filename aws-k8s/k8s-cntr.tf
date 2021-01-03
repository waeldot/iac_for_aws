resource "kubernetes_deployment" "tf_k8s_deploy_dev" {
  metadata {
    name = "ec-deploy-dev"
    namespace = "env-dev"
  }

  spec {
    replicas = 2
    progress_deadline_seconds = 600

    selector {
      match_labels = {
        podname = "ec-app-dev"
      }
    }

    template {
      metadata {
        labels = {
          podname = "ec-app-dev"
        }
      }

      spec {
        container {
          image = "${var.registry}/app:${var.tagno}"
          name  = "ecweb"
          port {
           container_port = 80
          }   
          volume_mount {
            name = "appdata"
            mount_path = "/appdata"
          }
          command = [ "/opt/nginx/sbin/nginx", "-g daemon off;" ]
        }
        container {
          image = "${var.registry}/app:${var.tagno}"
          name  = "ecwas"
          port {
           container_port = 8080
          }
          volume_mount {
            name = "appdata"
            mount_path = "/appdata"
          }
          command = [ "/opt/tomcat/bin/catalina.sh", "run" ]
        }
        volume {
          name = "appdata"
          persistent_volume_claim {
            claim_name = "ggr-efspvc-dev"
          }
        }
      }#spec
    }
  }
}
