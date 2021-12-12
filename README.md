# Hyper

## About
This is a test repository for local deployment multi-node Kubernetes cluster with `Terraform` and `KinD`.
Two simple services `foo` and` bar` are located behind the `NGINX` ingress controller and periodically benchmark with `ab` tool along the appropriate paths. Collection and visualization of metrics is providing by `Prometheus` and `Grafana` operators.

## Prerequisites
To test this deployment you have to have:
- Terraform
- Docker
- Kubectl

## Installation

1. Clone repository and change working folder
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

