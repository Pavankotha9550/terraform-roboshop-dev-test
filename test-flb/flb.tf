module "flb" {
  source = "terraform-aws-modules/alb/aws"
  version= "9.16.0"
  name    = "${var.project}-${var.environment}-application-FLB"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = split("," ,data.aws_ssm_parameter.private_subnet_id.value)
  internal= false
  create_security_group= false
  security_groups=[data.aws_ssm_parameter.sg_id.value]



  tags = {
    Environment = "Development"
    Project     = var.project
  }
}

resource "aws_lb_listener" "fixed_response" {
  load_balancer_arn = module.alb.arn
  port              = "8080"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_ssm_parameter.daws84-arn-flb


  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>html default fixed responce from ALB<h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "backend-alb" {
  zone_id =  data.aws_route53_zone.daws84.zone_id
  name    = "daws84.cyou"
  type    = "A"

  alias {
    name                   = module.flb.dns_name
    zone_id                = module.flb.zone_id
    evaluate_target_health = true
  }
}
