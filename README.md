Requirements
-----

- Terraform v1.0.11
- aws-cli v2
- Helm v3
- Docker v4
- kubectl v1.21

Usage
-----
- Update ~/.aws/credentials file to use credentials from AWS recruit-account
- Place **.env** file with API key app/ directory
- Deploy AWS infrastructure using Terraform:
```
cd aws
terraform init
terraform plan
terraform apply
```
- Run these commands to let kubectl connect to EKS cluster and verify this:
```
aws eks --region us-east-1 update-kubeconfig --name aws-eks-cluster
kubectl cluster-info
```
- Authenticate Docker to an Amazon ECR registry:
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 092592202483.dkr.ecr.us-east-1.amazonaws.com
```
- Build Docker image:
```
cd app/ && docker build -t weather-app .
```
- Tag Docker image to use ECR repository:
```
docker tag weather-app 092592202483.dkr.ecr.us-east-1.amazonaws.com/weather-app
```
- Push Docker image to ECR repository:
```
docker push 092592202483.dkr.ecr.us-east-1.amazonaws.com/weather-app
```
- Deploy application to EKS cluster using Helm:
```
cd app/weather-app-chart
helm install weather-app .
```