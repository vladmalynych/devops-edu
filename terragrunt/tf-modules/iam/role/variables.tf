variable "environment" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "role_name" {
  description = "Name of the role"
  type        = string
}

variable "role_policy_arns" {
  description = "ARNs of any policies to attach to the IAM role"
  type        = list(string)
  default     = []
}
