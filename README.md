## About the repository
This test repository for local setup multi-node Kubernetes cluster with Terraform and KinD.

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

