data "aws_ami" "DevOps_practice_ami_id" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["973714476881"] 
}

data "aws_ssm_parameter" "mongodb"{
    name= "/${var.project}/${var.environment}/mongodb-sg_id"
}

data "aws_ssm_parameter" "redis"{
    name= "/${var.project}/${var.environment}/redis-sg_id"
}

data "aws_ssm_parameter" "mysql"{
    name= "/${var.project}/${var.environment}/mysql-sg_id"
}

data "aws_ssm_parameter" "rabbitmq"{
    name= "/${var.project}/${var.environment}/rabbitmq-sg_id"
}

data "aws_ssm_parameter" "database_subnet_id"{
    name= "/${var.project}/${var.environment}/database_subnet_ids"
}

