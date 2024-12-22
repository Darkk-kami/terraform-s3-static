# The domain name to be managed in Route 53.
variable "domain_name" {
  description = "The domain name for the hosted zone and records."
  type        = string
}

# Domain validation options for ACM certificate validation.
variable "domain_validation_options" {
  description = "The domain validation options required for ACM certificate validation."
  type        = any
}

# CloudFront distribution details required for creating an alias record.
variable "cloudfront" {
  description = "The CloudFront distribution details, including domain name and hosted zone ID."
  type = object({
    domain_name    = string
    hosted_zone_id = string
  })
}