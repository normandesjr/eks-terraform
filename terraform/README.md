Ao rodar pela primeira vez teremos um erro no module.eks.kubernetes_config_map.aws_auth

Aí faça:

terraform ouput e veja o nome do cluster, no caso desse projeto é training_eks_cluster, então rode:

aws eks --region us-east-1 update-kubeconfig --name training_eks_cluster --profile zup

Added new context arn:aws:eks:us-east-1:746213696263:cluster/training_eks_cluster to /Users/normandesjr/.kube/config

Rode o terraform apply mais uma vez, agora vai funcionar.

Então rode: kubectl apply -f config_map_aws_auth.yaml

Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
configmap/aws-auth configured

Problema 1: Como fazer rodar e funcionar de 1ª o Terraform?
Problema 2: Como tirar esse warning do kubectl apply do config_map_aws_auth?

