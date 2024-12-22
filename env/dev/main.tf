module "acm_certificate" {
  count        = var.create_custom_domain ? 1 : 0
  source      = "../../modules/acm"
  domain_name = var.domain_name
}

module "s3" {
  source                = "../../modules/s3-static-website"
  cloudfront_oac_policy = module.cloudfront.cloudfront_oac_policy
}

module "cloudfront" {
  source          = "../../modules/cloudfront"
  domain_name     = var.domain_name
  aws_s3_bucket   = module.s3.aws_s3_bucket
  environment     = var.environment
  acm_certificate = var.create_custom_domain ? module.acm_certificate.acm_certificate_arn : null
  use_custom_domain   = var.create_custom_domain
}

module "route53" {
  count = var.create_custom_domain ? 1 : 0
  source                    = "../../modules/route53"
  cloudfront                = module.cloudfront.cloudfront_distribution
  domain_validation_options = var.create_custom_domain ? module.acm_certificate.aws_acm_certificate_validation : null
  domain_name               = var.domain_name
}