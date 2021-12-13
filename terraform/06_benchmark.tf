locals {
  ingress_endpoint = "http://ingress-nginx-controller:80"
  concurrency      = 100
  requests         = 1000
}

resource "kubernetes_cron_job" "benchmark_foo" {
  metadata {
    name = "banchmark-foo"
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 5
    schedule                      = "*/5 * * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name  = "ab"
              image = "jordi/ab"
              args = [
                "-k",
                "-c", local.concurrency,
                "-n", local.requests,
                join("", [local.ingress_endpoint, "/foo/"])
              ]
            }
          }
        }
      }
    }
  }
  depends_on = [
    kind_cluster.default,
  ]
}

resource "kubernetes_cron_job" "benchmark_bar" {
  metadata {
    name = "banchmark-bar"
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 5
    schedule                      = "*/5 * * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name  = "ab"
              image = "jordi/ab"
              args = [
                "-k",
                "-c", local.concurrency,
                "-n", local.requests,
                join("", [local.ingress_endpoint, "/bar/"])
              ]
            }
          }
        }
      }
    }
  }
  depends_on = [
    kind_cluster.default,
  ]
}
