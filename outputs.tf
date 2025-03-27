# Output values for the website hosting infrastructure

output "s3_bucket_id" {
  description = "The ID of the S3 bucket hosting the website content"
  value       = module.website_bucket.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket hosting the website content"
  value       = module.website_bucket.s3_bucket_arn
}

output "s3_bucket_website_domain" {
  description = "The domain of the website endpoint for the S3 bucket"
  value       = module.website_bucket.s3_bucket_website_domain
}

output "s3_bucket_website_endpoint" {
  description = "The website endpoint URL for the S3 bucket"
  value       = module.website_bucket.s3_bucket_website_domain
}
  
  output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = module.website_cdn.distribution_id
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.website_cdn.distribution_domain_name
}

output "website_url" {
  description = "The complete URL to access the website through CloudFront"
  value       = "https://${module.website_cdn.distribution_domain_name}"
}