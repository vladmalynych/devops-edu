output "k8s_sa_metadata_annotation" {
  description = "ID of the node shared security group"
  value       = "'eks.amazonaws.com/role-arn': '${module.this.iam_role_arn}'"
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = module.this.iam_role_arn
}
