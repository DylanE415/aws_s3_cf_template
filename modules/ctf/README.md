# terraform-aws-cloudfront-s3-cdn Module

This Terraform module provisions a CloudFront distribution with an S3 bucket as its origin. It is designed to optimize content delivery for static websites by leveraging AWS CloudFront CDN features including caching behaviors and, optionally, an automatic creation of an Origin Access Identity (OAI) to secure S3 bucket access.

## Features

- Configures a CloudFront distribution with a single S3 bucket origin.
- Sets up default cache behavior with GET, HEAD, and OPTIONS methods.
- Enables IPv6 and uses the default CloudFront certificate for SSL.
- Optionally creates an Origin Access Identity if one is not provided, which can be used to restrict direct access to your S3 bucket.

## Usage

Declare the module in your Terraform configuration and provide at least the `bucket_domain_name`. For example:

```hcl
module "cdn" {
  source = "path/to/modules/ctf"

  bucket_domain_name = "your-bucket-name.s3.amazonaws.com"
  # Optionally specify an existing OAI if available
  # origin_access_identity = "origin-access-identity/cloudfront/EXAMPLE"

  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  tags                = {
    Environment = "prod"
  }
}
```

## Inputs

| Name                    | Description                                                                 | Type         | Default             |
|-------------------------|-----------------------------------------------------------------------------|--------------|---------------------|
| bucket_domain_name      | The domain name of the S3 bucket (e.g., bucket-name.s3.amazonaws.com).       | string       | n/a                 |
| origin_access_identity  | Optional CloudFront Origin Access Identity; if empty, one will be created.     | string       | ""                |
| default_root_object     | The default root object to serve (usually index.html).                       | string       | "index.html"      |
| price_class             | The price class for the CloudFront distribution.                             | string       | "PriceClass_100"  |
| tags                    | A map of tags to assign to the CloudFront distribution.                      | map(string)  | {}                  |

## Outputs

| Name                         | Description                                           |
|------------------------------|-------------------------------------------------------|
| distribution_id              | The ID of the CloudFront distribution.                |
| distribution_domain_name     | The domain name of the CloudFront distribution.       |

## Notes

- The module uses the AWS and Random providers. Ensure they are configured appropriately in your environment.
- The caller reference for the distribution is auto-generated using a random ID to ensure uniqueness.

