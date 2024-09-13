# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for example. The common variables for each environment to
# deploy example are defined here. This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder. If any environment
# needs to deploy a different module version, it should redefine this block with a different ref to override the
# deployed version.
terraform {
  source = "${local.source_base_url}//example?ref=example"
  # source = "../../../../../terraform-modules//eks"
}

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Source URL for Example terraform modules. Clones the repo over SSH.
  source_base_url = "git@github.com:example/terraform-examples.git"
}

dependency "example" {
  config_path = "${get_terragrunt_dir()}/../dummy"

  mock_outputs = {
    example_id       = "example-dummy-1234567890"
    private_examples = ["example-dummy-1234567890", "example-dummy-0987654321"]
  }
}

generate "example-provider" {
  path      = "example-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "example" {
    name = "dummy"

    config = {
        option_1 = "dummy"
    }
}
EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  example = "dummy"
}
