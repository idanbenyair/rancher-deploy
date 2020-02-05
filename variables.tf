variable "aws_access_keys" {
  type = "map"
  description = "AWS Access Keys for terraform deployment"

  default = {
      access_key = ""
      secret_key = ""
      region = "us-east-1"
  }
}

variable "subnets" {
  type = "map"
  description = "Available subnets in this deployment"

  default = {
    subnet01 = "subnet-16ca4a71"
    subnet02 = "subnet-2e2e7e64"
  }
}

variable "ami_id" {
  type = string
  description = "Ubuntu AMI"
  default = "ami-04763b3055de4860b"
}

variable "instance_type" {
  type = string
  description = "The instance type of the node"
  default = "t2.large"
}

variable "key_name" {
  type = string
  description = "Keypair name"
  default = "k8s-test"
}

variable "user_data_file" {
  type = string
  description = "User data to install rancher in HA"
  default = "scripts/user_data.tpl"
}
