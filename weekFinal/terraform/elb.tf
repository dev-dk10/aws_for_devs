resource "aws_elb" "edu-lohika-training-aws-load-balancer" {
  name = "load-balancer"
  internal = false
  security_groups = [aws_security_group.edu-lohika-training-public-security_group.id]
  subnets = [aws_subnet.edu-lohika-training-aws-public-subnet.id]
  cross_zone_load_balancing = true

  listener {
    instance_port = 80
    instance_protocol = "HTTP"
    lb_port = 80
    lb_protocol = "HTTP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/actuator/health"
    interval            = 30
  }

}