# Output the hosted zone information for reference.
output "hosted_zone" {
  description = "The Route 53 hosted zone used for DNS management."
  value       = data.aws_route53_zone.selected_zone
}