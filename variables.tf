# Input variables for the website hosting infrastructure

variable "bucket_name" {
  description = "Name of the S3 bucket to store website content"
  type        = string
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "cloudfront_price_class" {
  description = "CloudFront price class to use. One of PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
  default     = "PriceClass_100"
  
  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.cloudfront_price_class)
    error_message = "CloudFront price class must be one of PriceClass_All, PriceClass_200, or PriceClass_100."
  }
}

variable "enable_logging" {
  description = "Whether to enable access logging for the S3 bucket"
  type        = bool
  default     = false
}

variable "logging_bucket" {
  description = "Name of the S3 bucket to store access logs, required if enable_logging is true"
  type        = string
  default     = ""
}