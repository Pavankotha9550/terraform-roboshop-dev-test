resource "aws_cloudfront_distribution" "roboshop" {
  origin {
    domain_name              = "daws84.cyou"
    #origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = "frontend-alb"

     custom_origin_config  {
        http_port              = 80 // Required to be set but not used
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  #is_ipv6_enabled     = true
  #comment             = "Some comment"
  #default_root_object = "index.html"



  aliases = ["cdn.daws84.cyou"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "frontend-alb"

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }

    viewer_protocol_policy = "https-only"
   /*  min_ttl                = 1
    default_ttl            = 3600
    max_ttl                = 86400 */
    cache_policy_id  = data.aws_cloudfront_cache_policy.cacheDisable.id
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "frontend-alb"

    cache_policy_id  = data.aws_cloudfront_cache_policy.cacheEnable.id

   /*  forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    } */

    /* min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true */
    viewer_protocol_policy = "https-only"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn = data.aws_ssm_parameter.daws84-arn-flb.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "cdn.daws84.cyou" #dev.daws84s.site
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.roboshop.domain_name
    zone_id                = aws_cloudfront_distribution.roboshop.hosted_zone_id
    evaluate_target_health = true
  }
}
