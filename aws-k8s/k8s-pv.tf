resource "kubernetes_persistent_volume" "ggr_efspv_dev" {
  metadata {
    name = "ggr-efspv-dev"
  }
  spec {
    capacity = {
      storage = "100Gi"
    }
    access_modes = ["ReadWriteMany"]
    storage_class_name = "efs-sc"
    persistent_volume_source { 
      csi {
        driver = "efs.csi.aws.com"
        volume_handle = var.efs-fs-id
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "ggr_efspvc_dev" {
  metadata {
    name = "ggr-efspvc-dev"
    namespace = "env-dev"
  }
  spec {
    resources {
      requests = {
        storage = "100Gi"
      }
    }
    storage_class_name = "efs-sc"
    access_modes = ["ReadWriteMany"]
    volume_name = kubernetes_persistent_volume.ggr_efspv_dev.metadata.0.name
  }
}
