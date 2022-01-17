data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

module "eks" {
  source          = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v17.23.0"

  cluster_version = "1.21"
  cluster_name = var.cluster_name
  vpc_id       = var.aws_vpc_id
  subnets      = var.aws_subnet_private_prod_ids

  worker_groups = [
    {
      instance_type = "t3.small"
      asg_max_size  = 5
    }
  ]
}