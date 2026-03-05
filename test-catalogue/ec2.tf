resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.DevOps_practice_ami_id.id
  instance_type = "t3.micro"
  vpc_security_group_ids= [data.aws_ssm_parameter.catalogue.value]
  subnet_id= split("," ,data.aws_ssm_parameter.private_subnet_id.value)[0]
  #iam_instance_profile= "EC2RoleToFetchSSMParameter"
  
  
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

resource "aws_launch_template" "catalogue" {
  name= "catalogue.${var.zone_name}"
  image_id = aws_ami_from_instance.catalogue.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue-sg_id.value]
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    # EC2 tags created by ASG
    tags = {
        Name = "${var.project}-${var.environment}-catalogue"
      }  
  }

  tag_specifications {
    resource_type = "volume"
    # EC2 tags created by ASG
    tags ={
        Name = "${var.project}-${var.environment}-catalogue"
      }  
  }

  tags ={
    Name= "${var.project}-${var.environment}-catalogue"
  }
}

resource "aws_autoscaling_group" "catalogue" {
  name     = "catalogue.${var.zone_name}"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  vpc_zone_identifier       = split("," ,data.aws_ssm_parameter.private_subnet_id.value)
  target_group_arns =[aws_lb_target_group.catalogue.arn]


  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }

  dynamic "tag" {
    for_each = {
        Name = "${var.project}-${var.environment}-catalogue"
      }

    content{
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
    
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

   timeouts{
    delete = "15m"
  }

}

resource "aws_autoscaling_policy" "catalogue" {
  name                   = "catalogue.${var.zone_name}"
  scaling_adjustment     = 1
  policy_type       = "TargetTrackingScaling"
  instance_warmup = 100
  #cooldown               = 100 this dosent work here
  autoscaling_group_name = aws_autoscaling_group.catalogue.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
}

resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = data.aws_ssm_parameter.alb-ARN.value
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.daws84.cyou"]
    }
  }
}

resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value
  deregistration_delay = 120 #time giving to instance to complete all the pending requests to complete 

  health_check{
    healthy_threshold =2 
    interval = 5
    matcher = "200-299"
    path = "/health"
    port = 8080
    timeout= 2
    unhealthy_threshold =3
  }
}
