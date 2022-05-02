resource "aws_security_group" "Security_group" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name    = "Carlos-SecurityGroup"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }
}

resource "aws_security_group" "Instance_sg" {
  name        = "Instance_sg"
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name    = "Carlos-SecurityGroup"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }

  ingress {
    from_port       = 22
    to_port         = 8081
    protocol        = "tcp"
    security_groups = [aws_security_group.Security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "Private_sg" {
  name        = "private_sg"
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name    = "Carlos-SecurityGroup"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }

}

resource "aws_security_group_rule" "Public_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.Security_group.id
}

resource "aws_security_group_rule" "Public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.Security_group.id
}

resource "aws_security_group_rule" "Public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.Security_group.id
}

resource "aws_security_group_rule" "Public_in_3030" {
  type              = "ingress"
  from_port         = 3030
  to_port           = 3030
  protocol          = "tcp"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.Security_group.id
}

resource "aws_security_group_rule" "Public_in_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.Security_group.id
}

resource "aws_security_group_rule" "Private_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.Private_sg.id
}

resource "aws_security_group_rule" "Private_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.Private_sg.id
}


