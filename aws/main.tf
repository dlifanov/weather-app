provider "aws" {
  region = "us-east-1"
}

locals {
  cluster_name = "aws-eks-cluster"
}

module vpc {
    source = "./modules/vpc" 
    cluster_name = local.cluster_name
}

module eks {
   source = "./modules/eks"
   cluster_name = local.cluster_name
   aws_subnet_private_prod_ids = module.vpc.aws_subnet_private_prod_ids
   aws_vpc_id = module.vpc.aws_vpc_id
}

module ecr {
    source = "./modules/ecr" 
}