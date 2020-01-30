output "elb-name" {
  value       = aws_elb.rancher-elb.name
  description = "The ID of the rancher security group"
}
