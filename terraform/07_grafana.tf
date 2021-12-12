resource "helm_release" "grafana_operator" {
  name       = "grafana-operator"

  repository = "../helm"
  chart      = "grafana-operator"

  depends_on = [
      kind_cluster.default,
      helm_release.prometheus
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"

  repository = "../helm"
  chart      = "grafana"

  depends_on = [
      kind_cluster.default,
      helm_release.grafana_operator
  ]
}