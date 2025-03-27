# AWS S3 CloudFront Website Hosting

This Terraform project deploys a static website hosting infrastructure using AWS S3 and CloudFront. The project leverages AWS best practices to ensure security, performance, and scalability.

## Architecture

![Architecture Diagram](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggTFJcbiAgICBBW1VzZXJzXSAtLT58SFRUUFMgUmVxdWVzdHN8IEJbQ2xvdWRGcm9udCBDRE5dXG4gICAgQiAtLT58T3JpZ2luIEFjY2VzcyBJZGVudGl0eXwgQ1tTMyBCdWNrZXRdXG4gICAgQyAtLT58TG9nZ2luZyBPcHRpb25hbHwgRFtMb2dnaW5nIFMzIEJ1Y2tldF1cbiAgICBzdHlsZSBBIGZpbGw6I2Y5ZixzdHJva2U6IzMzM1xuICAgIHN0eWxlIEIgZmlsbDojZjljLHN0cm9rZTojMzMzXG4gICAgc3R5bGUgQyBmaWxsOiNjZjksIHN0cm9rZTojMzMzXG4gICAgc3R5bGUgRCBmaWxsOiNjOWYsIHN0cm9rZTojMzMzIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifX0)

## Features

- **Secure S3 Website Hosting**: Content stored in a private S3 bucket
- **CloudFront CDN**: Global content delivery with low latency
- **Origin Access Identity**: Ensures content is only accessible via CloudFront
- **HTTPS Support**: Secure content delivery
- **Optional Logging**: Track access patterns and troubleshoot issues

## Prerequisites

- AWS Account
- Terraform >= 1.0.0
- AWS CLI configured with appropriate credentials

## Usage

1. Clone this repository
2. Update the `terraform.tfvars` file with your specific values (or create one)
3. Initialize Terraform:
   ```
   terraform init
   ```
4. Preview the changes:
   ```
   terraform plan
   ```
5. Apply the configuration:
   ```
   terraform apply
   ```

### Example `terraform.tfvars`

```hcl
bucket_name = "my-static-website-123"
force_destroy = true
aws_region = "us-east-1"
cloudfront_price_class = "PriceClass_100"
enable_logging = true
logging_bucket = "my-logs-bucket-123"
tags = {
  Environment = "Production"
  Project     = "Corporate Website"
}
```

## Uploading Content

After the infrastructure is deployed, you can upload your static website files to the S3 bucket using the AWS CLI:

```bash
aws s3 sync ./my-website-folder/ s3://my-static-website-123/
```

## Security Considerations

- The S3 bucket is private, and content is only accessible through CloudFront
- CloudFront uses HTTPS to secure content delivery
- The Origin Access Identity prevents direct access to S3 content

## Customization

This project can be customized by modifying the variables in `variables.tf` or by overriding them in your `terraform.tfvars` file.

## Cleanup

To destroy the infrastructure when no longer needed:

```
terraform destroy
```

## License

This project is licensed under the MIT License.