# Define an Origin Access Control (OAC) to securely connect CloudFront to the S3 bucket
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "s3-cloudfront-oac-${var.environment}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront distribution configuration for serving content from the S3 bucket
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  aliases             = var.use_custom_domain ? [var.domain_name] : [] # Custom domain name for the distribution
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  wait_for_deployment = true

  # Default caching behavior for the distribution
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.aws_s3_bucket.id
    viewer_protocol_policy = "redirect-to-https" # Enforce HTTPS

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # Origin configuration linking the S3 bucket with CloudFront
  origin {
    domain_name              = var.aws_s3_bucket.bucket_domain_name
    origin_id                = var.aws_s3_bucket.id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  # Restrict access based on geographic region (currently open to all)
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Viewer certificate for HTTPS using an ACM certificate
  viewer_certificate {
    acm_certificate_arn      = var.use_custom_domain ? var.acm_certificate : null
    cloudfront_default_certificate = var.use_custom_domain ? false : true
    minimum_protocol_version = "TLSv1.2_2021" # Ensure a secure TLS version
    ssl_support_method       = "sni-only"
  }
}

# IAM policy document allowing CloudFront to access S3 objects
data "aws_iam_policy_document" "cloudfront_oac" {
  statement {
    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }

    actions   = ["s3:GetObject"] # Grant access to retrieve objects from S3
    resources = ["${var.aws_s3_bucket.arn}/*"]

    condition {
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
      variable = "AWS:SourceArn" # Restrict access based on the CloudFront ARN
    }
  }
}





