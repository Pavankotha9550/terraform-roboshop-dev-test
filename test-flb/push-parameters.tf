resource "aws_ssm_parameter" "flb-ARN" {
  name  = "/${var.project}/${var.environment}/flb-ARN"
  type  = "String"
  value = module.alb.arn
}