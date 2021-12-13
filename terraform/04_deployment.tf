resource "kubernetes_deployment" "backend_foo" {
  metadata {
    name = "backend-foo"
    labels = {
      app = "backend-foo"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "backend-foo"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend-foo"
        }
      }

      spec {
        container {
          image = "hashicorp/http-echo"
          name  = "http-echo"
          args = [
            join("", ["-listen=:", var.backend_port]),
            "-text='foo'"
          ]
          port {
            container_port = var.backend_port
          }

          liveness_probe {
            http_get {
              path = "/foo"
              port = var.backend_port
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }

  depends_on = [
    kind_cluster.default,
  ]
}

resource "kubernetes_deployment" "backend_bar" {
  metadata {
    name = "backend-bar"
    labels = {
      app = "backend-bar"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "backend-bar"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend-bar"
        }
      }

      spec {
        container {
          image = "hashicorp/http-echo"
          name  = "http-echo"
          args = [
            join("", ["-listen=:", var.backend_port]),
            "-text='bar'"
          ]
          port {
            container_port = var.backend_port
          }

          liveness_probe {
            http_get {
              path = "/bar"
              port = var.backend_port
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }

  depends_on = [
    kind_cluster.default,
  ]
}
