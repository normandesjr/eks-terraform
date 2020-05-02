terraform {
  required_version = ">= 0.12.13"
  required_providers {
    aws        = "~> 2.43"
    kubernetes = "~> 1.8"
    local      = "~> 1.2"
    template   = "~> 2.1"
    helm       = "~> 0.10"
    external   = "~> 1.2"
    tls        = "~> 2.1"
    archive    = "~> 1.2"
    random     = "~> 2.1"
    null       = "~> 2.1"
  }
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_id
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
  
  service_account = "tiller"
  install_tiller  = true
  init_helm_home  = true
  debug           = true
}
