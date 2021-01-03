resource "kubernetes_namespace" "tf_ns_dev" {
  metadata {
    name = "env-dev"
  }
}
