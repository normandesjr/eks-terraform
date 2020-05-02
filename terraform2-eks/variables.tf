variable "cluster_name" {
  default = "hibicode_eks_cluster"
}

variable "region" {
  default = "us-east-1"
}

variable "user_profile" {
  default = "zup"
}

variable "iam_user" {
  default = "zup"
}

variable "private_subnet_ids" {}

variable "vpc_id" {}
