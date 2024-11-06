# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------
# Apply extra arguments to terraform command
terraform {
  # Force Terraform to keep trying to acquire a lock for up to 10 minutes
  # if someone else already has the lock
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=10m"]
  }
}

# Automatically store terraform state files in S3 bucket and create lock table in DynamoDB.
remote_state {
  backend = "s3"

  # Disable remote-state initialization (useful for terragrunt run-all validate)
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    profile        = local.backend_aws_profile # Local AWS profile name
    region         = local.aws_region
    encrypt        = true
    key            = format("%s/terraform.tfstate", path_relative_to_include()) # path from terragrunt.hcl to include
    bucket         = local.backend_s3_bucket
    dynamodb_table = local.backend_dynamodb_table
  }
}


# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.aws_region}"
  profile = "${local.aws_profile}"


  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.account_id}"]

  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "${local.env}"
      Project     = "${local.project_name}"
      Owner       = "${local.owner_name}"
    }
  }
}
EOF
}

terraform_version_constraint  = ">= 1.0"
terragrunt_version_constraint = ">= 0.40"

locals {
  # Automatically load variables from files in parent folders (files can be missing)
  global_vars      = try(read_terragrunt_config(find_in_parent_folders("global.hcl")), {})
  account_vars     = try(read_terragrunt_config(find_in_parent_folders("account.hcl")), {})
  region_vars      = try(read_terragrunt_config(find_in_parent_folders("region.hcl")), {})
  environment_vars = try(read_terragrunt_config(find_in_parent_folders("env.hcl")), {})

  # Merge variables from multiple sources, deeper variables override higher variables (locals can be empty)
  merged_vars = merge(
    lookup(local.global_vars, "locals", {}),
    lookup(local.account_vars, "locals", {}),
    lookup(local.region_vars, "locals", {}),
    lookup(local.environment_vars, "locals", {})
  )

  # Extract variables for easier manipulation
  aws_region          = lookup(local.region_vars.locals, "aws_region", "eu-central-1")
  account_name        = lookup(local.account_vars.locals, "account_name", "default-account")
  account_id          = lookup(local.account_vars.locals, "account_id", "1234567890")
  aws_profile         = lookup(local.account_vars.locals, "aws_profile", "default")
  backend_aws_profile = lookup(local.account_vars.locals, "backend_aws_profile", "default")
  backend_s3_bucket   = lookup(local.account_vars.locals, "backend_s3_bucket", "my-default-bucket")
  backend_dynamodb_table = lookup(local.account_vars.locals, "backend_dynamodb_table", "terraform-locks")
  env                 = lookup(local.environment_vars.locals, "environment", "dev")
  project_name        = lookup(local.global_vars.locals, "project_name", "MyProject")
  owner_name          = lookup(local.global_vars.locals, "owner_name", "MyOwner")
}

inputs = (
  local.merged_vars
)