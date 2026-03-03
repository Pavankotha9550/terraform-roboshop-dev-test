resource "aws_ssm_parameter" "bastion" {
  name  = "/${var.project}/${var.environment}/bastion-sg_id"
  type  = "String"
  value = module.sg_id-bastion.sg_id
}

resource "aws_ssm_parameter" "alb" {
  name  = "/${var.project}/${var.environment}/alb-sg_id"
  type  = "String"
  value = module.sg_id-alb.sg_id
}

resource "aws_ssm_parameter" "vpn" {
  name  = "/${var.project}/${var.environment}/vpn-sg_id"
  type  = "String"
  value = module.sg_id-vpn.sg_id
}

resource "aws_ssm_parameter" "mongodb" {
  name  = "/${var.project}/${var.environment}/mongodb-sg_id"
  type  = "String"
  value = module.sg_id-mongodb.sg_id
}

resource "aws_ssm_parameter" "redis" {
  name  = "/${var.project}/${var.environment}/redis-sg_id"
  type  = "String"
  value = module.sg_id-redis.sg_id
}

resource "aws_ssm_parameter" "mysql" {
  name  = "/${var.project}/${var.environment}/mysql-sg_id"
  type  = "String"
  value = module.sg_id-mysql.sg_id
}

resource "aws_ssm_parameter" "rabbitmq" {
  name  = "/${var.project}/${var.environment}/rabbitmq-sg_id"
  type  = "String"
  value = module.sg_id-rabbitmq.sg_id
}