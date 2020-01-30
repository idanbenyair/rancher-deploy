variable "aws_access_keys" {
  type = "map"
  description = "AWS Access Keys for terraform deployment"

  default = {
      access_key = "AKIA3AWHOUMW7HDZQR3U"
      secret_key = "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"
      region = "us-east-1"
  }
}

variable "user_data_file" {
  type = string
  description = "User data to install rancher in HA"
  default = "scripts/test.sh"
}
