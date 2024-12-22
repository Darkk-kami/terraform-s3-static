# Define the environment variable (e.g., dev, staging, production).
variable "environment" {
  description = "The deployment environment (e.g., dev, staging, production)."
  type        = string
  default     = "dev"
}

# Define the variable for CloudFront OAC policy.
variable "cloudfront_oac_policy" {
  description = "The CloudFront Origin Access Control (OAC) policy JSON document."
  type        = any
}