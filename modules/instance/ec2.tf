resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key
  user_data     = file(var.userdata)
  network_interface {
    network_interface_id = var.network_interface_id
    device_index         = 0
  }

  tags = {
    Name    = "${var.name}"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }

}