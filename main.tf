provider "aws" {
  access_key      = "${lookup(var.aws_access_keys, "access_key")}"
  secret_key      = "${lookup(var.aws_access_keys, "secret_key")}"
  region          = "${lookup(var.aws_access_keys, "region")}"
}

#resource "aws_placement_group" "ranch-placement" {
#  name     = "ranch-group"
#  strategy = "cluster"
#}

resource "aws_launch_template" "rancher-launch-config" {
  name_prefix   = "rancher-launch-config"
  image_id      = "ami-04763b3055de4860b"
  instance_type = "t2.large"
  user_data = "${base64encode(file("${var.user_data_file}"))}"
  key_name = "k8s-test"
}

resource "aws_autoscaling_group" "rancher-ha" {
  name                      = "rancher-ha-cluster"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
#  placement_group           = "${aws_placement_group.ranch-placement.id}"
#  launch_configuration      = "${aws_launch_template.rancher-launch-config.name}"
#  vpc_zone_identifier       = ["${aws_subnet.example1.id}", "${aws_subnet.example2.id}"]
  vpc_zone_identifier       = ["subnet-06205a09", "subnet-0cfe7350"]

  launch_template {
    id      = "${aws_launch_template.rancher-launch-config.id}"
    version = "$Latest"
  }

  initial_lifecycle_hook {
    name                 = "lifecycle-continue"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 30
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
#  timeouts {
#    delete = "15m"
#  }
  }
}