resource "aws_ssm_parameter" "alb-ARN" {
  name  = "/${var.project}/${var.environment}/alb-ARN"
  type  = "String"
  value = module.alb.arn
}