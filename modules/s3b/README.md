# AWS S3 Bucket Terraform Module

This Terraform module creates an AWS S3 bucket configured for static website hosting. It supports key features including access logging, versioning, CORS configuration, and lifecycle rules.

## Features

- Static website hosting
- Access logging
- Versioning
- CORS configuration
- Lifecycle rules

## Usage

Below is an example of how to use this module:

```hcl
module "s3_bucket" {
  source = "./modules/s3b"

  bucket = "my-s3-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

  website = {
    index_document = "index.html"
    error_document = "error.html"
    routing_rules  = [
      {
        condition = {
          key_prefix_equals = "docs/"
        },
        redirect = {
          replace_key_prefix_with = "documents/"
        }
      }
    ]
  }

  logging = {
    target_bucket = "logs-bucket"
    target_prefix = "log/"
  }

  tags = {
    Environment = "dev"
  }
}
```

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0

For more details, see the [Terraform AWS S3 Bucket Module](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket).
