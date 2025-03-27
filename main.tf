# Main Terraform configuration file for S3 + CloudFront Website Hosting

# Create S3 bucket to host website content
module "website_bucket" {
  source = "./modules/s3b"

  bucket        = var.bucket_name
  acl           = "private"  # Keep bucket private, content served through CloudFront
  force_destroy = var.force_destroy

  # Enable website hosting configuration
  website = {
    index_document = "index.html"
    error_document = "error.html"
    routing_rules  = []
  }

  # Enable versioning for protection against accidental deletions
  versioning = {
    enabled = true
  }

  # Configure access logging if enabled
  logging = var.enable_logging ? {
    target_bucket = var.logging_bucket
    target_prefix = "logs/${var.bucket_name}/"
  } : {
    target_bucket = ""
    target_prefix = ""
  }

  tags = var.tags
}

# Create CloudFront distribution for content delivery
module "website_cdn" {
  source = "./modules/ctf"

  bucket_domain_name  = module.website_bucket.s3_bucket_website_domain
  default_root_object = "index.html"
  price_class         = var.cloudfront_price_class

  # Leave this empty to auto-create a new Origin Access Identity
  origin_access_identity = ""

  tags = var.tags
}

# Create S3 bucket policy to allow access only from CloudFront OAI
resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = module.website_bucket.s3_bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${module.website_cdn.cloudfront_origin_access_identity}"
        }
        Action   = "s3:GetObject"
        Resource = "${module.website_bucket.s3_bucket_arn}/*"
      }
    ]
  })

  depends_on = [module.website_bucket, module.website_cdn]
}