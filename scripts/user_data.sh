#! bin/bash -x

#Install docker https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04
sudo apt-get update
sudo apt install docker.io
usermod -aG docker ubuntu

#Generate ssh keys
ssh-keygen -b 2048 -t rsa -f /home/ubuntu/.ssh/id_rsa -N ""
cat /home/ubuntu/.ssh/id_rsa.pub /home/ubuntu/.ssh/authorized_keys

#Install RKE
sudo wget -O /usr/local/bin/rke https://github.com/rancher/rke/releases/download/v1.0.3/rke_linux-amd64
sudo chmod +x /usr/local/bin/rke

#Create cluster.yml file

#Install kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

#Install helm https://helm.sh/docs/intro/install/
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

#Make symbolic link
mkdir -p /home/ubuntu/.kube
ln -s /home/ubuntu/kube_config_rancher-cluster.yml /home/ubuntu/.kube/config

#Export path
export KUBECONFIG=/home/ubuntu/kube_config_rancher-cluster.yml

#RKE Up to build the cluster
sudo sudo rke up --config rancher-cluster.yml

#Cert manager
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.9/deploy/manifests/00-crds.yaml
kubectl create namespace cert-manager
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

#Install Rancher
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update
kubectl create namespace cattle-system
#helm install rancher-latest/rancher --namespace cattle-system --set hostname=<DNS Name> --generate-name