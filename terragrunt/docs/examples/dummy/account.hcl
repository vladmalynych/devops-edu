# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.

locals {
  account_id   = 13371337
  account_name = "dummy"
  aws_profile  = "aws-dummy"
}
