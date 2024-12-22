output "cloudfront_domain" {
  value = module.cloudfront.cloudfront_distribution.domain_name
}