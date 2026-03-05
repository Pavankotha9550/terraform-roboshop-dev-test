
resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.DevOps_practice_ami_id.id
  instance_type = "t3.micro"
  vpc_security_group_ids= [data.aws_ssm_parameter.mongodb.value]
  subnet_id= split("," ,data.aws_ssm_parameter.database_subnet_id.value)[0]
  
  tags = {
    Name="${var.project}-${var.environment}-mongodb"
  }
}

resource "terraform_data" "mongodb"{
  triggers_replace=[
    aws_instance.mongodb.id
  ]

  provisioner "file"{
    source= "bootstrap.sh"
    destination= "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}

resource "aws_instance" "redis" {
  ami           = data.aws_ami.DevOps_practice_ami_id.id
  instance_type = "t3.micro"
  vpc_security_group_ids= [data.aws_ssm_parameter.redis.value]
  subnet_id= split("," ,data.aws_ssm_parameter.database_subnet_id.value)[0]
  
  tags = {
    Name="${var.project}-${var.environment}-redis"
  }
}

resource "terraform_data" "redis"{
  triggers_replace=[
    aws_instance.redis.id
  ]

  provisioner "file"{
    source= "bootstrap.sh"
    destination= "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis"
    ]
  }
}

resource "aws_instance" "mysql" {
  ami           = data.aws_ami.DevOps_practice_ami_id.id
  instance_type = "t3.micro"
  vpc_security_group_ids= [data.aws_ssm_parameter.mysql.value]
  subnet_id= split("," ,data.aws_ssm_parameter.database_subnet_id.value)[0]
  iam_instance_profile= "EC2RoleToFetchSSMParameter"
  
  tags = {
    Name="${var.project}-${var.environment}-mysql"
  }
}

resource "terraform_data" "mysql"{
  triggers_replace=[
    aws_instance.mysql.id
  ]

  provisioner "file"{
    source= "bootstrap.sh"
    destination= "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
  }

   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql"
    ]
  }
}

resource "aws_instance" "rabbitmq" {
  ami           = data.aws_ami.DevOps_practice_ami_id.id
  instance_type = "t3.micro"
  vpc_security_group_ids= [data.aws_ssm_parameter.rabbitmq.value]
  subnet_id= split("," ,data.aws_ssm_parameter.database_subnet_id.value)[0]
  
  tags = {
    Name="${var.project}-${var.environment}-rabbitmq"
  }
}

resource "terraform_data" "rabbitmq"{
  triggers_replace=[
    aws_instance.mongodb.id
  ]

  provisioner "file"{
    source= "bootstrap.sh"
    destination= "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }

   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq"
    ]
  }
}