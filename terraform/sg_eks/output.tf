output "security_group_id" {
  description = "Security Group ID created for EKS"
  value       = aws_security_group.security_group.id
}
