variable "project"{
    default="roboshop"
}

variable "environment"{
    default="dev"
}

variable "zone_name"{
    default= "daws84.cyou"
}

data "aws_ssm_parameter" "catalogue-sg_id" {
  name = "/${var.project}/${var.environment}/catalogue-sg_id"
}