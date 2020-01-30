output "sg-id" {
  value       = aws_security_group.rancher-sg.id
  description = "The ID of the rancher security group"
}
