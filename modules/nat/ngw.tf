resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = var.allocation_id
  subnet_id     = var.subnet_nat
  tags = {
    Name    = "NatGateway"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }
}

resource "aws_route_table" "privatetable" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name    = "Carlos-routetable"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }
}

resource "aws_route_table_association" "rtable" {
  subnet_id      = var.subnet_target
  route_table_id = aws_route_table.privatetable.id
}
