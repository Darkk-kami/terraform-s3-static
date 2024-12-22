# Fetch the Route 53 hosted zone information based on the domain name provided.
data "aws_route53_zone" "selected_zone" {
  name = var.domain_name
}

# Create Route 53 DNS records for validating the ACM certificate.
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in var.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.selected_zone.id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 60
}

# Create a Route 53 alias record to point the domain to the CloudFront distribution.
resource "aws_route53_record" "cloudfront_record" {
  name    = var.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.selected_zone.zone_id

  alias {
    evaluate_target_health = false
    name                   = var.cloudfront.domain_name
    zone_id                = var.cloudfront.hosted_zone_id
  }
}