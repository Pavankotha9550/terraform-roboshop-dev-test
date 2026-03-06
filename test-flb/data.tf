data "aws_ssm_parameter" "sg_id" {
  name = "/${var.project}/${var.environment}/flb-sg_id"
}

data "aws_ssm_parameter" "public_subnet_id"{
    name= "/${var.project}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_route53_zone" "daws84" {
  name         = "daws84.cyou"
}

data "aws_ssm_parameter" "daws84-arn-flb" {
  name = "/${var.project}/${var.environment}/daws84-arn-flb"
}