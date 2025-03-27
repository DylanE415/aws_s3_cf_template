/*
  Outputs for the CloudFront S3 CDN module
*/

output "distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_domain_name" {
  description = "The domain name of the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_origin_access_identity" {
  description = "The CloudFront Origin Access Identity."
  value       = aws_cloudfront_origin_access_identity.this[0].id
}