curl -LO https://dl.k8s.io/release/v1.34.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin
kubectl version

 curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
 sudo ./aws/install --update

aws configure
Provide access_key, secret_key
aws eks update-kubeconfig --region ap-southeast-1 --name congthanh-eks
docker login -u buicongthanh861@gmail.com -p ******** https://trialuitjen.jfrog.io

