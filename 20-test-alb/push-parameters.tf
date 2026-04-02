resource "aws_ssm_parameter" "alb-ARN" {
  name  = "/${var.project}/${var.environment}/alb-ARN-lisitner"
  type  = "String"
  value = aws_lb_listener.fixed_response.arn
}