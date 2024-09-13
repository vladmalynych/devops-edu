variable "environment" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "s3_buckets" {
  description = "The bucket map needs to be created and then allowed RW access from EKS"
  type = map(object({
    bucket_public_access_block = optional(object({
      block_public_acls       = optional(bool)
      block_public_policy     = optional(bool)
      ignore_public_acls      = optional(bool)
      restrict_public_buckets = optional(bool)
    }))
    cors_rules = optional(list(object({
      allowed_headers = list(string)
      allowed_methods = list(string)
      allowed_origins = list(string)
      max_age_seconds = optional(number)
    })))
    versioning = optional(bool)
  }))
  default = {}
}
