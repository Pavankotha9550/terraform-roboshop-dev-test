resource "aws_ssm_parameter" "daws84-arn-flb" {
  name  = "/${var.project}/${var.environment}/daws84-arn-flb"
  type  = "String"
  value = aws_acm_certificate.daws84.arn
}