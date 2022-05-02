resource "aws_db_instance" "movie_db" {
  identifier             = var.identifier
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = "movie_db"
  username               = "Admin"
  password               = "password"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.movie_db.id
  vpc_security_group_ids = [var.security_groups]
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "movie_db" {
  name       = "movie_db"
  subnet_ids = var.subnets

  tags = {
    Name = "movie_db"
  }
}