resource "kubernetes_ingress" "backend_ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "backend-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
    labels = {
      app = "nginx-ingress"
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = kubernetes_service.backend_foo.metadata.0.name
            service_port = var.backend_port
          }

          path = "/foo"
        }

        path {
          backend {
            service_name = kubernetes_service.backend_bar.metadata.0.name
            service_port = var.backend_port
          }

          path = "/bar"
        }
      }
    }

  }
}

output "load_balancer_ip" {
  value = kubernetes_ingress.backend_ingress.status.0.load_balancer.0.ingress.0.ip
}