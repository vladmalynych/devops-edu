variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "region" {
  type        = string
  description = "The AWS region where the bucket will be created"
}

variable "environment" {
  type        = string
  description = "The environment (e.g. dev, prod)"
}
