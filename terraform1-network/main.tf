provider "aws" {
  version = "~> 2.43"
  region  = var.region
  profile = var.user_profile
}
