resource "kubernetes_service" "backend_foo" {
  metadata {
    name = kubernetes_deployment.backend_foo.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.backend_foo.metadata.0.labels.app
    }

    port {
      port        = var.backend_port
      target_port = var.backend_port
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "backend_bar" {
  metadata {
    name = kubernetes_deployment.backend_bar.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.backend_bar.metadata.0.labels.app
    }

    port {
      port        = var.backend_port
      target_port = var.backend_port
    }

    type = "ClusterIP"
  }
}