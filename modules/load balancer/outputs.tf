output "id" {
  description = "LB_ID"
  value       = aws_elb.lb.id
}

output "lb_endpoint" {
  value = aws_elb.lb.dns_name
}