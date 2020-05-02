provider "aws" {
  version = "~> 2.43"
  region  = var.region
  profile = var.user_profile
}

data "aws_iam_user" "iam_user" {
  user_name = var.iam_user
}
