resource "aws_subnet" "RU_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.ippublic
  tags = {
    Name    = "Carlos-${var.subnet_tag}"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }
}