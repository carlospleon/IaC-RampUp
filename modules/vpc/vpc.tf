resource "aws_vpc" "VPC" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name    = "Carlos-RUVPC"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }
}
