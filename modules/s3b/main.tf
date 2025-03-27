resource "aws_s3_bucket" "this" {
  bucket        = var.bucket
  force_destroy = var.force_destroy
  acl           = var.acl

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning.enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = (var.website.index_document != "" && var.website.error_document != "") ? 1 : 0
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = var.website.index_document
  }

  error_document {
    key = var.website.error_document
  }

  dynamic "routing_rule" {
    for_each = length(var.website.routing_rules) > 0 ? var.website.routing_rules : []
    content {
      dynamic "condition" {
        for_each = lookup(routing_rule.value, "condition", {}) != {} ? [routing_rule.value.condition] : []
        content {
          http_error_code_returned_equals = lookup(condition.value, "http_error_code_returned_equals", null)
          key_prefix_equals               = lookup(condition.value, "key_prefix_equals", null)
        }
      }
      redirect {
        host_name               = lookup(routing_rule.value, "redirect", {})["host_name"]
        http_redirect_code      = lookup(routing_rule.value, "redirect", {})["http_redirect_code"]
        protocol                = lookup(routing_rule.value, "redirect", {})["protocol"]
        replace_key_prefix_with = lookup(routing_rule.value, "redirect", {})["replace_key_prefix_with"]
        replace_key_with        = lookup(routing_rule.value, "redirect", {})["replace_key_with"]
      }
    }
  }
}

resource "aws_s3_bucket_logging" "this" {
  count = (var.logging.target_bucket != "" && var.logging.target_prefix != "") ? 1 : 0

  bucket        = aws_s3_bucket.this.id
  target_bucket = var.logging.target_bucket
  target_prefix = var.logging.target_prefix
}
