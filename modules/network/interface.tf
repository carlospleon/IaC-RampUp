resource "aws_network_interface" "Interface" {
  subnet_id       = var.subnet_id
  private_ips     = var.private_ips
  security_groups = var.security

  tags = {
    Name    = "Carlos-NetworkInterface"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }
}