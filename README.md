# Hyper
Playground repository for local deployment multi-node Kubernetes cluster with `Terraform` and `KinD`.
Two simple services `foo` and` bar` are located behind the `NGINX` ingress controller and periodically benchmark with `ab` tool along the appropriate endpoints. Collection and visualization of the metrics implemented with `Prometheus` and `Grafana` operators.

![Deployment](https://github.com/maggnus/hyper/blob/main/contrib/deployment.png)

## Prerequisites
Tools required to apply this deployemnt:
- Terraform
- Docker
- Kubectl

## Installation

1. Clone repository and change working directory
    ```sh
    git clone git@github.com:maggnus/hyper.git
    cd hyper/terraform
    ```
2. Apply terraform scripts
   ```sh
   terraform init
   terraform apply
   ```
3. Check deployment
    ```sh
    kubectl get pods,svc
    ```

### Grafana
Grafana manifest allow anonymous access and set admin credentials to `admin/admin`
```yaml
apiVersion: integreatly.org/v1alpha1
kind: Grafana
metadata:
  name: grafana
spec:
  client:
    preferService: true
  ingress:
    enabled: True
    pathType: Prefix
    path: "/"
  config:
    log:
      mode: "console"
      level: "error"
    log.frontend:
      enabled: true
    security:
      admin_user: "admin"
      admin_password: "admin"
    auth:
      disable_login_form: False
      disable_signout_menu: True
    auth.anonymous:
      enabled: True
  service:
    name: "grafana-service"
    labels:
      app: "grafana"
      type: "grafana-service"
  dashboardLabelSelector:
    - matchExpressions:
        - { key: app, operator: In, values: [grafana] }
  resources:
    # Optionally specify container resources
    limits:
      cpu: 200m
      memory: 200Mi
    requests:
      cpu: 100m
      memory: 100Mi
```


## Dashboard
Grafana dashboard creates with special Kubernetes resources `GrafanaDashboard` and could be provision dynamicly.
```yaml
apiVersion: integreatly.org/v1alpha1
kind: GrafanaDashboard
metadata:
  name: dashboard
  labels:
    app: grafana
spec:
  json: >
    {{`{
      "editable": true,
      "gnetId": null,
      "graphTooltip": 0,
      ...
```

Exmaple:

![Dashboard](https://github.com/maggnus/hyper/blob/main/contrib/dashboard.png)
