# Generate a unique suffix for the S3 bucket name to ensure global uniqueness.
resource "random_string" "bucket_suffix_id" {
  length    = 8
  lower     = true
  special   = false
  min_lower = 8
}

# Create an S3 bucket for hosting the static website.
resource "aws_s3_bucket" "static_website" {
  bucket        = "kami-website-${random_string.bucket_suffix_id.result}"
  force_destroy = true # Ensures the bucket is deleted even if it contains objects

  tags = {
    Name        = "kami-website"
    Environment = var.environment
  }
}

# Configure the S3 bucket for static website hosting.
resource "aws_s3_bucket_website_configuration" "static_website_configurations" {
  bucket = aws_s3_bucket.static_website.id

  # Specify the index document for the website
  index_document {
    suffix = "index.html"
  }

  # Specify the error document for the website
  error_document {
    key = "error.html"
  }
}

# Define the S3 bucket policy to grant permissions to the CloudFront origin access control (OAC).
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_website.id
  policy = var.cloudfront_oac_policy.json

}

# Define a local variable to manage the static files and their paths.
locals {
  files = {
    "index.html"             = "static/index.html"
    "styles.css"             = "static/styles.css"
    "images/dancing_cat.gif" = "static/images/dancing_cat.gif"
  }
}

# Upload static files to the S3 bucket.
resource "aws_s3_object" "static_files" {
  for_each = local.files

  bucket = aws_s3_bucket.static_website.id
  key    = each.key
  source = "${path.module}/../../${each.value}"
  content_type = lookup({
    "index.html"             = "text/html",
    "styles.css"             = "text/css",
    "images/dancing_cat.gif" = "image/gif"
  }, each.key, "application/octet-stream") # Default content type
}