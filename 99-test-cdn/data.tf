data "aws_cloudfront_cache_policy" "cacheEnable" {
  name = "Managed-CachingOptimized"  # Replace with the name of your cache policy
}

data "aws_cloudfront_cache_policy" "cacheDisable" {
  name = "Managed-CachingDisabled"  # Replace with the name of your cache policy
}

data "aws_ssm_parameter" "daws84-arn-flb" {
  name = "/${var.project}/${var.environment}/daws84-arn-flb"
}