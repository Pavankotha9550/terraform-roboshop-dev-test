data "aws_ami" "openvpn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] 
}

data "aws_ssm_parameter" "bastion"{
    name= "/${var.project}/${var.environment}/vpn-sg_id"
}

data "aws_ssm_parameter" "public_subnet_id"{
    name= "/${var.project}/${var.environment}/public_subnet_ids"
}

