variable "cluster_name" {}

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

variable "cluster_id" {}
