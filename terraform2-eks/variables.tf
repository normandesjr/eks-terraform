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

variable "private_subnet_ids" {
  default = ["subnet-0a445b81db7447fdb","subnet-0e50cd0d93049aeb3","subnet-085d4a9aee9662da7"]
}

variable "vpc_id" {
  default = "vpc-09d5261349d444c74"
}
