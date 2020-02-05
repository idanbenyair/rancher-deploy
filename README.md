# Deploying highly available K8s cluster using RKE
RKE is a useful tool that help with configuring K8s clusters. In this use case we will deploy a highly available K8s cluster using RKE.
We will also use Terraform in order to deploy the required compute resources into AWS.

## The following infra diagram describes the resources that will be deployed
![alt text](images/rke-aws.png)

## Services that will be installed on the ndoes
 - Docker
 - RKE
 - kubectl
 - Helm

## Use Terraform to deploy the infrastructure

1. Install Terraform: [How to install Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) 

2. Edit the Terraform provider information in order to deploy to AWS. You can use access keys, or you could configure the AWS CLI. Another option is to  use an IAM role.

3. Run the following to initiate the terraform deployment

```
terraform init

terraform apply
```

## Post install

1. SSH into the master node using its public IP

2. Edit the `rancher-cluster.yml` and update the IP addresses of the nodes. Also, update the  path to your SSH private key ([How to create SSH key pairs](https://help.ubuntu.com/community/SSH/OpenSSH/Keys)) for authentication between the nodes.

```
nodes:
  - address: <Node01 IP Address>
    user: ubuntu
    role: [controlplane,etcd,worker]
    ssh_key_path: /path/to/privatekey.pem
  - address: <Node02 IP Address>
    user: ubuntu
    role: [controlplane,etcd,worker]
    ssh_key_path: /path/to/privatekey.pemm
  - address: <Node03 IP Address>
    user: ubuntu
    role: [controlplane,etcd,worker]
    ssh_key_path: /path/to/privatekey.pem
addon_job_timeout: 120
```

3. Run the up command to initiate the creation of the cluster
`rke up config rancher-cluster.yml`

You will then see the following output. This output indecates that the setup has started and that the tunnels to the hosts have been created. Using the SSH key pair fro the previous step.

![alt text](images/tunnel.png)

After a few moments you will get a success output:

![alt text](images/success.png)

4. Create a symbolic link and export path to the kubeconfig

```
mkdir -p /home/ubuntu/.kube
ln -s /home/ubuntu/kube_config_rancher-cluster.yml /home/ubuntu/.kube/config

export KUBECONFIG=/home/ubuntu/kube_config_rancher-cluster.yml
```
5. Check that the cluster is running properly

`kubectl get nodes`

This should give you the running nodes in the cluster

![alt text](images/kubectl.png)
