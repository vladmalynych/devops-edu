output "buckets_info" {
  description = "ARN of the bucket"
  value = {
    for k, v in aws_s3_bucket.this : k => {
      arn    = v.arn,
      bucket = v.bucket
    }
  }
}
