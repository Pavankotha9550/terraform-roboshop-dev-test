module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version= "9.16.0"
  name    = "${var.project}-${var.environment}-application-ALB"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = split("," ,data.aws_ssm_parameter.public_subnet_id.value)
  internal= true
  create_security_group= false
  security_groups=[data.aws_ssm_parameter.sg_id.value]



  tags = {
    Environment = "Development"
    Project     = var.project
  }
}

resource "aws_lb_listener" "fixed_response" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>html default fixed responce from ALB<h1>"
      status_code  = "200"
    }
  }
}
