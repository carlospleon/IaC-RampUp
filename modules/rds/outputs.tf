output "endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.movie_db.endpoint
}