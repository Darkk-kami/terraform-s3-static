output "website_endpoint" {
  description = "The website endpoint for accessing the static site hosted on S3."
  value       = aws_s3_bucket_website_configuration.static_website_configurations.website_endpoint
}

output "aws_s3_bucket" {
  description = "The S3 bucket details for the static website."
  value       = aws_s3_bucket.static_website
}
