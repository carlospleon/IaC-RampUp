output "id" {
  description = "id of Internet Gateway"
  value       = aws_internet_gateway.gateway.id
}

output "allocation_id" {
  description = "id of EIP"
  value       = aws_eip.nat_gateway.allocation_id
}