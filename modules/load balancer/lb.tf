# Create a new load balancer
resource "aws_elb" "lb" {
  name            = "app-movie"
  subnets         = var.subnets
  security_groups = var.security
  instances = var.instance

  listener {
    instance_port     = 30007
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:30007/"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name    = "Carlos-LoadBalancer"
    Owner   = "Carlos Parada"
    Project = "Ramp Up"
    DU      = "BOD"
  }
}