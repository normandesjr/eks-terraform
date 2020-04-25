module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  subnets      = module.vpc.private_subnets

  tags = {
    Environment = "training"
  }

  vpc_id = module.vpc.vpc_id

  kubeconfig_aws_authenticator_env_variables = {
    AWS_PROFILE = "zup"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

resource "local_file" "config_map" {
  content = templatefile("${path.module}/auth/config_map_aws_auth.tmpl", {cluster_iam_role_arn = module.eks.cluster_iam_role_arn})
  filename = "./config_map_aws_auth.yaml"
}