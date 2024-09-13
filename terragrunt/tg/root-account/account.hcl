# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.

locals {
  account_id   = 998902540689
  account_name = "vladmalynych"
  aws_profile  = "vladmalynych"
  backend_aws_profile = local.aws_profile
  backend_s3_bucket = edu_tf_state
}
