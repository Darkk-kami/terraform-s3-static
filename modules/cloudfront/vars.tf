variable "domain_name" {
  description = "The custom domain name for the CloudFront distribution."
  type        = string
}

variable "aws_s3_bucket" {
  description = "Details of the S3 bucket for the static website."
  type = object({
    id                 = string
    arn                = string
    bucket_domain_name = string
  })
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)."
  type        = string
}

variable "acm_certificate" {
  description = "The ARN of the ACM certificate for HTTPS."
  type        = string
  default     = null
}

variable "use_custom_domain" {
  type        = bool
  description = "Indicates whether a custom domain is being used."
  default     = false
}


