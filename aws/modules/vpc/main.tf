module "vpc" {
  source = "git::ssh://git@github.com/reactiveops/terraform-vpc.git?ref=v5.0.1"
# EKS cluster reqiures at least 2 AZs
  aws_region = "us-east-1"
  az_count   = 2
  aws_azs    = "us-east-1a, us-east-1b"

  global_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

output "aws_vpc_id" {
  value = module.vpc.aws_vpc_id
}

output "aws_subnet_private_prod_ids" {
  value = module.vpc.aws_subnet_private_prod_ids
}