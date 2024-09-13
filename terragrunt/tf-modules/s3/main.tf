resource "aws_s3_bucket" "this" {
  for_each = var.s3_buckets
  bucket   = each.key
}

resource "aws_s3_bucket_ownership_controls" "this" {
  for_each = var.s3_buckets
  bucket   = aws_s3_bucket.this[each.key].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]
  for_each   = var.s3_buckets
  bucket     = aws_s3_bucket.this[each.key].id
  acl        = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = var.s3_buckets
  bucket   = aws_s3_bucket.this[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "this" {
  for_each = { for k, v in var.s3_buckets : k => v if try(length(v.cors_rules), 0) > 0 }
  bucket   = aws_s3_bucket.this[each.key].id

  dynamic "cors_rule" {
    for_each = each.value.cors_rules

    content {
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, null)
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  for_each = { for k, v in var.s3_buckets : k => v.bucket_public_access_block if v.bucket_public_access_block != null }
  bucket   = aws_s3_bucket.this[each.key].id

  block_public_acls       = each.value.block_public_acls
  block_public_policy     = each.value.block_public_policy
  ignore_public_acls      = each.value.ignore_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "this" {
  for_each = { for k, v in var.s3_buckets : k => v.versioning if v.versioning != null }
  bucket   = aws_s3_bucket.this[each.key].id

  versioning_configuration {
    status = each.value ? "Enabled" : "Suspended"

  }
}
