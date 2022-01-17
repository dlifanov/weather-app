variable "cluster_name" {
    type = string
}

variable "aws_vpc_id" {
    type = string
}

variable "aws_subnet_private_prod_ids" {
    type = list(string)
}