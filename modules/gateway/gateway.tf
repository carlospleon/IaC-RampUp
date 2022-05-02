resource "aws_internet_gateway" "gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name    = "Carlos-VPCRU"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }
}

resource "aws_eip" "nat_gateway" {
  vpc        = true
  depends_on = [aws_internet_gateway.gateway]
}