
## Deploy and access Kubernetes Dashboard

Download and unzip the metric server:

````
wget -O v0.3.6.tar.gz https://codeload.github.com/kubernetes-sigs/metrics-server/tar.gz/v0.3.6 && tar -xzf v0.3.6.tar.gz
````

Deploy the metrics server:

````
kubectl apply -f metrics-server-0.3.6/deploy/1.8+/
````

Verify that metrics server has been deployed:

````
kubectl get deployment metrics-server -n kube-system
````

Deploy Kubernetes Dashboard

````
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
````

Now, create a proxy server:

````
kubectl proxy
````

Should be accessible:

````
http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
````

Authenticate the dashboard

````
kubectl apply -f https://raw.githubusercontent.com/hashicorp/learn-terraform-provision-eks-cluster/master/kubernetes-dashboard-admin.rbac.yaml
````

Then, generate the authorization token:

````
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')
````

Select "Token" on the Dashboard UI then copy and paste the entire token received.
