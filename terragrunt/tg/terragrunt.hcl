# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
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

  config = {
    profile        = local.backend_aws_profile # Local AWS profile name
    region         = "eu-central-1"
    encrypt        = true
    key            = format("%s/terraform.tfstate", path_relative_to_include())
    bucket         = local.backend_s3_bucket
    dynamodb_table = format("edu-terraform-states-locks")
  }
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  profile = "${local.aws_profile}"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.account_id}"]

  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "${local.env}"
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
  aws_region          = local.region_vars.locals.aws_region
  account_name        = local.account_vars.locals.account_name
  account_id          = local.account_vars.locals.account_id
  aws_profile         = local.account_vars.locals.aws_profile
  backend_aws_profile = local.account_vars.locals.backend_aws_profile
  backend_s3_bucket   = local.account_vars.locals.backend_s3_bucket
  env                 = local.environment_vars.locals.environment
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = (
  local.merged_vars
)
