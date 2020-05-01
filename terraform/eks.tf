module "eks" {
  source                = "terraform-aws-modules/eks/aws"
  version               = ">= 1.11.1"
  cluster_name          = var.cluster_name
  subnets               = module.vpc.private_subnets
  # manage_cluster_iam_resources = false
  # cluster_iam_role_name = aws_iam_role.aws-iam-eks-master-poc-eks-academy.name

  tags = {
    Environment = "hibicode"
  }

  vpc_id = module.vpc.vpc_id

  config_output_path = pathexpand("~/.kube/config")

  kubeconfig_aws_authenticator_env_variables = {
    AWS_PROFILE = "zup"
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
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      kubelet_extra_args            = "--cloud-provider=aws"
      # iam_instance_profile_name     = aws_iam_instance_profile.aws-iam-node-profile-poc-eks-academy.name
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
