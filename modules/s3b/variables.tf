variable "region" {
  description = "AWS region to deploy the bucket"
  type        = string
  default     = "us-east-2"
}

variable "bucket" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "cloudGoDeployment"
}

variable "force_destroy" {
  description = "If true, all objects in the bucket will be deleted on destroy"
  type        = bool
  default     = true
}

variable "acl" {
  description = "Canned ACL to apply to the bucket"
  type        = string
  default     = "private"
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "versioning" {
  description = "Bucket versioning configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "website" {
  description = "Website configuration for the bucket"
  type = object({
    index_document  = string
    error_document  = string
    routing_rules   = list(any)
  })
  default = {
    index_document = ""
    error_document = ""
    routing_rules  = []
  }
}

variable "logging" {
  description = "Access logging configuration for the bucket"
  type = object({
    target_bucket = string
    target_prefix = string
  })
  default = {
    target_bucket = "",
    target_prefix = ""
  }
}

variable "cors_rule" {
  description = "CORS rules for the bucket"
  type = list(object({
    allowed_methods = list(string)
    allowed_origins = list(string)
    allowed_headers = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  }))
  default = []
}

variable "lifecycle_rule" {
  description = "Lifecycle rules for the bucket"
  type = list(any)
  default = []
}
