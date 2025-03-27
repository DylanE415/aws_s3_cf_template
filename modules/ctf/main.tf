/*
  This module provisions a CloudFront distribution with an S3 bucket origin.
  It optimizes content delivery for a static website by configuring caching behaviors
  and optionally creating an Origin Access Identity (OAI) if one is not provided.
*/

resource "random_id" "caller_reference" {
  byte_length = 8
}

resource "aws_cloudfront_origin_access_identity" "this" {
  count   = var.origin_access_identity == "" ? 1 : 0
  comment = "OAI for ${var.bucket_domain_name != "" ? var.bucket_domain_name : var.bucket_name}"
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  default_root_object = var.default_root_object
  is_ipv6_enabled     = true
  price_class         = var.price_class

  origin {
    domain_name = var.bucket_domain_name
    origin_id   = "s3-origin"

    s3_origin_config {
      origin_access_identity = var.origin_access_identity != "" ? var.origin_access_identity : aws_cloudfront_origin_access_identity.this[0].cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods       = ["GET", "HEAD", "OPTIONS"]
    cached_methods        = ["GET", "HEAD"]
    target_origin_id      = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }


  tags = var.tags
}
