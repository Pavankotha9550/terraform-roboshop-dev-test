module "sg_id-frontend"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description=var.description
    server="frontend"
    
}

module "sg_id-bastion"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description=var.description2
    server="bastion"
}

module "sg_id-alb"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="ALB security group"
    server="ALB loadbalancer"
}

module "sg_id-vpn"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="VPN security group"
    server="VPN"
}

module "sg_id-mongodb"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="mongodb security group"
    server="mongodb"
}

module "sg_id-redis"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="redis security group"
    server="redis"
}

module "sg_id-mysql"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="mysql security group"
    server="mysql"
}

module "sg_id-rabbitmq"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="rabbitmq security group"
    server="rabbitmq"
}

module "sg_id-catalogue"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="catalogue security group"
    server="catalogue"
}

module "sg_id-user"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="user security group"
    server="user"
}

module "sg_id-cart"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="cart security group"
    server="cart"
}

module "sg_id-shipping"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="shipping security group"
    server="shipping"
}

module "sg_id-payment"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="payment security group"
    server="payment"
}

module "sg_id-flb"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//10-module-sg?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    environment=var.environment
    project=var.project
    description="FLB security group"
    server="FLB loadbalancer"
}


#bastion accepting connections form any laptop
resource "aws_security_group_rule" "bastion_laptop"{
    type= "ingress"
    from_port= 22
    to_port= 22
    protocol= "tcp"
    cidr_blocks=["0.0.0.0/0"]
    security_group_id= module.sg_id-bastion.sg_id

}

#ALB accepting connections form Bastion
resource "aws_security_group_rule" "alb"{
    type= "ingress"
    from_port= 80
    to_port= 80
    protocol= "tcp"
    source_security_group_id= module.sg_id-bastion.sg_id
    security_group_id= module.sg_id-alb.sg_id
}

#to connect to VPC we need to open 22,443,943,1194
resource "aws_security_group_rule" "VPC-SSH"{
    type= "ingress"
    from_port= 22
    to_port= 22
    protocol= "tcp"
    cidr_blocks=["0.0.0.0/0"]
    security_group_id= module.sg_id-vpn.sg_id
}

#to connect to VPC we need to open 22,443,943,1194
resource "aws_security_group_rule" "VPC-HTTPS"{
    type= "ingress"
    from_port= 443
    to_port= 443
    protocol= "tcp"
    cidr_blocks=["0.0.0.0/0"]
    security_group_id= module.sg_id-vpn.sg_id
}

#to connect to VPC we need to open 22,443,943,1194
resource "aws_security_group_rule" "VPC-943"{
    type= "ingress"
    from_port= 943
    to_port= 943
    protocol= "tcp"
    cidr_blocks=["0.0.0.0/0"]
    security_group_id= module.sg_id-vpn.sg_id
}

#to connect to VPC we need to open 22,443,943,1194
resource "aws_security_group_rule" "VPC-1194"{
    type= "ingress"
    from_port= 1194
    to_port= 1194
    protocol= "tcp"
    cidr_blocks=["0.0.0.0/0"]
    security_group_id= module.sg_id-vpn.sg_id
}

#ALB accepting connections form Bastion
resource "aws_security_group_rule" "vpn"{
    type= "ingress"
    from_port= 80
    to_port= 80
    protocol= "tcp"
    source_security_group_id= module.sg_id-vpn.sg_id
    security_group_id= module.sg_id-alb.sg_id
}

#mongodb accepting connections form vpn
resource "aws_security_group_rule" "mongodb"{
    count=length(var.mongodb_ports_vpn)
    type= "ingress"
    from_port= var.mongodb_ports_vpn[count.index]
    to_port= var.mongodb_ports_vpn[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-vpn.sg_id
    security_group_id= module.sg_id-mongodb.sg_id
}

#redis accepting connections form vpn
resource "aws_security_group_rule" "redis"{
    count=length(var.redis_ports_vpn)
    type= "ingress"
    from_port= var.redis_ports_vpn[count.index]
    to_port= var.redis_ports_vpn[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-vpn.sg_id
    security_group_id= module.sg_id-redis.sg_id
}

#mysql accepting connections form vpn
resource "aws_security_group_rule" "mysql"{
    count=length(var.mysql_ports_vpn)
    type= "ingress"
    from_port= var.mysql_ports_vpn[count.index]
    to_port= var.mysql_ports_vpn[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-vpn.sg_id
    security_group_id= module.sg_id-mysql.sg_id
}

#mysql accepting connections form shipping
resource "aws_security_group_rule" "mysql_ports_shipping"{
    count=length(var.mysql_ports_shipping)
    type= "ingress"
    from_port= var.mysql_ports_shipping[count.index]
    to_port= var.mysql_ports_shipping[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-shipping.sg_id
    security_group_id= module.sg_id-mysql.sg_id
}

#rabbitmq accepting connections form vpn
resource "aws_security_group_rule" "rabbitmq"{
    count=length(var.rabbitmq_ports_vpn)
    type= "ingress"
    from_port= var.rabbitmq_ports_vpn[count.index]
    to_port= var.rabbitmq_ports_vpn[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-vpn.sg_id
    security_group_id= module.sg_id-rabbitmq.sg_id
}

#rabbitmq accepting connections form payment
resource "aws_security_group_rule" "rabbitmq_ports_payment"{
    count=length(var.rabbitmq_ports_payment)
    type= "ingress"
    from_port= var.rabbitmq_ports_payment[count.index]
    to_port= var.rabbitmq_ports_payment[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-payment.sg_id
    security_group_id= module.sg_id-rabbitmq.sg_id
}

#catalogue accepting connections form vpn
resource "aws_security_group_rule" "catalogue_ports_vpn"{
    count=length(var.catalogue_ports_vpn)
    type= "ingress"
    from_port= var.catalogue_ports_vpn[count.index]
    to_port= var.catalogue_ports_vpn[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-vpn.sg_id
    security_group_id= module.sg_id-catalogue.sg_id
}

#catalogue accepting connections form bastion
resource "aws_security_group_rule" "catalogue_ports_bastion"{
    count=length(var.catalogue_ports_bastion)
    type= "ingress"
    from_port= var.catalogue_ports_bastion[count.index]
    to_port= var.catalogue_ports_bastion[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-bastion.sg_id
    security_group_id= module.sg_id-catalogue.sg_id
}

#catalogue accepting connections form alb
resource "aws_security_group_rule" "catalogue_ports_alb"{
    count=length(var.catalogue_ports_alb)
    type= "ingress"
    from_port= var.catalogue_ports_alb[count.index]
    to_port= var.catalogue_ports_alb[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-alb.sg_id
    security_group_id= module.sg_id-catalogue.sg_id
}

#mongodb accepting connections form catalogue
resource "aws_security_group_rule" "mongodb_ports_catalogue"{
    count=length(var.mongodb_ports_catalogue)
    type= "ingress"
    from_port= var.mongodb_ports_catalogue[count.index]
    to_port= var.mongodb_ports_catalogue[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-catalogue.sg_id
    security_group_id= module.sg_id-mongodb.sg_id
}

#mongodb accepting connections form user
resource "aws_security_group_rule" "mongodb_ports_user"{
    count=length(var.mongodb_ports_user)
    type= "ingress"
    from_port= var.mongodb_ports_user[count.index]
    to_port= var.mongodb_ports_user[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-user.sg_id
    security_group_id= module.sg_id-mongodb.sg_id
}

#redis accepting connections form user
resource "aws_security_group_rule" "redis_ports_user"{
    count=length(var.redis_ports_user)
    type= "ingress"
    from_port= var.redis_ports_user[count.index]
    to_port= var.redis_ports_user[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-user.sg_id
    security_group_id= module.sg_id-redis.sg_id
}

#redis accepting connections form cart
resource "aws_security_group_rule" "redis_ports_cart"{
    count=length(var.redis_ports_cart)
    type= "ingress"
    from_port= var.redis_ports_cart[count.index]
    to_port= var.redis_ports_cart[count.index]
    protocol= "tcp"
    source_security_group_id= module.sg_id-cart.sg_id
    security_group_id= module.sg_id-redis.sg_id
}


