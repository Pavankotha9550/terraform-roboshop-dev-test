resource "aws_route53_record" "mongodb" {
  zone_id =  data.aws_route53_zone.daws84.zone_id
  name    = "mongodb.daws84.cyou"
  type    = "A"
  ttl = 1
  records= [aws_instance.mongodb.private_ip]
  allow_overwrite= true
}

resource "aws_route53_record" "redis" {
  zone_id =  data.aws_route53_zone.daws84.zone_id
  name    = "redis.daws84.cyou"
  type    = "A"
  ttl = 1
  records= [aws_instance.redis.private_ip]
  allow_overwrite= true
}

resource "aws_route53_record" "mysql" {
  zone_id =  data.aws_route53_zone.daws84.zone_id
  name    = "mysql.daws84.cyou"
  type    = "A"
  ttl = 1
  records= [aws_instance.mysql.private_ip]
  allow_overwrite= true
}

resource "aws_route53_record" "rabbitmq" {
  zone_id =  data.aws_route53_zone.daws84.zone_id
  name    = "rabbitmq.daws84.cyou"
  type    = "A"
  ttl = 1
  records= [aws_instance.rabbitmq.private_ip]
  allow_overwrite= true
}