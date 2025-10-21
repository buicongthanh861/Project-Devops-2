sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

terraform plan -destroy -target=module.eks
terraform apply -target=module.sgs -target=module.eks
