resource "aws_ssm_parameter" "flb-ARN" {
  name  = "/${var.project}/${var.environment}/flb-ARN-lisitner"
  type  = "String"
  value = aws_lb_listener.fixed_response.arn
}

#aws_lb_listener" "fixed_response