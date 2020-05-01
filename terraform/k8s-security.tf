# resource "kubernetes_service_account" "tiller" {
#   metadata {
#     name      = "tiller"
#     namespace = "kube-system"
#   }
#   depends_on = [
#     module.eks
#     # aws_autoscaling_group.aws-autoscaling-group-nodes
#   ]
# }

# resource "kubernetes_cluster_role_binding" "tiller" {
#   metadata {
#     name = "tiller"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = "tiller"
#     namespace = "kube-system"
#   }

#   depends_on = [
#     kubernetes_service_account.tiller
#   ]
# }

module "tiller" {
  source  = "iplabs/tiller/kubernetes"
  version = "3.2.1"
}