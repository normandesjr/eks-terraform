module "eks" {
  source                = "terraform-aws-modules/eks/aws"
  version               = ">= 1.11.1"
  cluster_name          = var.cluster_name
  subnets               = var.private_subnet_ids

  tags = {
    Environment = "hibicode"
  }

  vpc_id = var.vpc_id

  config_output_path = pathexpand("~/.kube/config")

  kubeconfig_aws_authenticator_env_variables = {
    AWS_PROFILE = var.user_profile
  }

  workers_additional_policies = [
    aws_iam_policy.aws_alb_ingress_controller.arn,
  ]

  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/local.tf
  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id, aws_security_group.database.id]
      kubelet_extra_args            = "--cloud-provider=aws"
    }
  ]

  map_users = [
    {
      userarn  = data.aws_iam_user.iam_user.arn
      username = data.aws_iam_user.iam_user.user_name
      groups   = ["system:masters"]
    }
  ]
}

resource "local_file" "config_map" {
  content = templatefile("${path.module}/auth/config_map_aws_auth.tmpl"
    , {cluster_iam_role_arn = module.eks.cluster_iam_role_arn, user_arn = data.aws_iam_user.iam_user.arn, user_name = data.aws_iam_user.iam_user.user_name})
  filename = "./config_map_aws_auth.yaml"
}
