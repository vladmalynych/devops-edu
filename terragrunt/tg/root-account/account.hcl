# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.

locals {
  account_id   = 998902540689
  account_name = "vladmalynych"
  aws_profile  = "vladmalynych"
  backend_aws_profile = local.aws_profile
  backend_s3_bucket = "devops-edu-terragrunt-state"
  backend_dynamodb_table = "devops-edu-terragrunt-lock"
}

# # Account-specific configurations that can be inherited by environment configurations
# inputs = {
#   account_name = local.account_name
#   account_id   = local.account_id
#   aws_profile  = local.aws_profile
# }
