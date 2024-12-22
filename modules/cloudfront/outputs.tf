output "cloudfront_distribution" {
  value = aws_cloudfront_distribution.s3_distribution
}

output "cloudfront_oac_policy" {
  value = data.aws_iam_policy_document.cloudfront_oac
}