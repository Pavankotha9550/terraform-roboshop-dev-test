resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.DevOps_practice_ami_id.id
  instance_type = "t3.micro"
  vpc_security_group_ids= [data.aws_ssm_parameter.catalogue.value]
  subnet_id= split("," ,data.aws_ssm_parameter.private_subnet_id.value)[0]
  #iam_instance_profile= "EC2RoleToFetchSSMParameter"
  deregistration_delay = 120 #time giving to instance to complete all the pending requests to complete 
  
  tags = {
    Name="${var.project}-${var.environment}-catalogue"
  }
}

resource "aws_route53_record" "catalogue" {
  zone_id =  data.aws_route53_zone.daws84.zone_id
  name    = "${var.server}.daws84.cyou"
  type    = "A"
  ttl = 1
  records= [aws_instance.catalogue.private_ip]
  allow_overwrite= true
}

resource "terraform_data" "catalogue"{
  triggers_replace=[
    aws_instance.catalogue.id
  ]

  provisioner "file"{
    source= "bootstrap.sh"
    destination= "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue"
    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [terraform_data.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue]
  tags = {
      Name = "${var.project}-${var.environment}-catalogue"
    }

}

resource "terraform_data" "catalogue_delete" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  
  # make sure you have aws configure in your laptop
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  }

  depends_on = [aws_ami_from_instance.catalogue]
}
