resource "kubernetes_cron_job" "avg_requests" {
  metadata {
    name = "avg-requests"
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
              name    = "metrics"
              image   = "curlimages/curl"
              args    = [
                "curl",
                "-s",
                 "http://prometheus-operated:9090/api/v1/query?query=rate(nginx_ingress_controller_nginx_process_requests_total%5B5m%5D)"
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
