resource "helm_release" "aws-alb-ingress-controller" {
  name       = "aws-alb-ingress-controller"
  repository = "incubator"
  chart      = "incubator/aws-alb-ingress-controller"
  version    = "0.1.11"
  namespace  = "aws-alb-ingress-controller"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "awsVpcID"
    value = var.vpc_id
  }

}