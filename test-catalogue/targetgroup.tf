resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value

  health_check{
    healthy_threshold =2 
    interval = 5
    matcher = "200-299"
    path = "/health"
    port = 8080
    timeout= 2
    unhealthy_threshold =3
  }
}

