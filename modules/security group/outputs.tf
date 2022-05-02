output "id" {
  description = "SG ID"
  value       = aws_security_group.Security_group.id
}

output "Instance_SG_id" {
  description = "SG ID"
  value       = aws_security_group.Instance_sg.id
}

output "private_SG_id" {
  description = "SG ID"
  value       = aws_security_group.Private_sg.id
}