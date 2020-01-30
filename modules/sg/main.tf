resource "aws_security_group" "rancher-sg" {
  name        = "${var.sg_name}"
  description = "Allow inbound traffic inside the rancher cluster"
  vpc_id      = "${var.vpc-id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}
