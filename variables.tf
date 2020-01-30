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
    subnet01 = ""
    subnet02 = ""
  }
}

variable "user_data_file" {
  type = string
  description = "User data to install rancher in HA"
  default = "scripts/user_data.tpl"
}
