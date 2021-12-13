# Hyper
Playground repository for local deployment multi-node Kubernetes cluster with `Terraform` and `KinD`.
Two simple services `foo` and` bar` are located behind the `NGINX` ingress controller and periodically benchmark with `ab` tool along the appropriate endpoints. Collection and visualization of the metrics implemented with `Prometheus` and `Grafana` operators.

![Deployment](https://github.com/maggnus/hyper/contrib/deployment.png)

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

