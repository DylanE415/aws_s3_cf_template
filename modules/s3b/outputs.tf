output "s3_bucket_id" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.this.id
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.this.arn
}

output "s3_bucket_website_domain" {
  description = "The website domain of the bucket (if website configuration is applied)"
  value       = aws_s3_bucket.this.website_domain
}

output "s3_bucket_region" {
  description = "The AWS region where the bucket is deployed"
  value       = aws_s3_bucket.this.region
}
