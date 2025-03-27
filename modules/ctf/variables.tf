/*
  Variables for the CloudFront S3 CDN module
*/

variable "bucket_domain_name" {
  description = "The S3 bucket domain name (e.g., bucket-name.s3.amazonaws.com or website endpoint)."
  type        = string
  default     = "cloudgotest.s3.amazonaws.com"
}

variable "origin_access_identity" {
  description = "Optional CloudFront Origin Access Identity. If empty, one will be created automatically."
  type        = string
  default     = ""
}

variable "default_root_object" {
  description = "The default root object to serve (usually index.html)."
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "The price class for the CloudFront distribution (e.g., PriceClass_100)."
  type        = string
  default     = "PriceClass_100"
}

variable "tags" {
  description = "A map of tags to assign to the CloudFront distribution."
  type        = map(string)
  default     = {}
}
