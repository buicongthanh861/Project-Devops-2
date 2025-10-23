kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring
kubectl edit svc prometheus-kube-prometheus-prometheus -n monitoring
kubectl edit svc prometheus-grafana -n monitoring
username: admin
password: prom-operator