
resource "aws_instance" "vpn" {
  ami           = data.aws_ami.openvpn.id
  instance_type = "t3.micro"
  vpc_security_group_ids= [data.aws_ssm_parameter.bastion.value]
  subnet_id= split("," ,data.aws_ssm_parameter.public_subnet_id.value)[0]

  key_name= "openvpn" #make sure this key exist in aws
  #key_name= aws_key_pair.openvpc.key_name

  user_data= file ("openvpn.sh")
  
  tags = {
    Name="${var.project}-${var.environment}-vpn"
  }
}

/*resource "aws_key_pair" "openpvn"{
  key_name= "keys.pub"
  public_key = file (C:\\dev-84s\\keys.pub)
}*/
