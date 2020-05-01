provider "aws" {
  version = ">= 2.28.1"
  region  = "us-east-1"
  profile = "zup"
}

data "aws_iam_user" "iam_user" {
  user_name = "zup"
}
