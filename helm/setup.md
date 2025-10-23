curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add stable https://charts.helm.sh/stable
helm install demo-mysql stable/mysql 

helm create ttrend
helm package ttrend
helm install ttrend ttrend-0.1.0.tgz
helm list -a
kubectl config set-context --current --namespace=congthanh