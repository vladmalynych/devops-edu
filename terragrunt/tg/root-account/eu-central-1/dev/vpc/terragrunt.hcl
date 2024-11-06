terraform {
  source = "../../../../../tf-modules//vpc/"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  cidr = "10.11.0.0"
  deployment_prefix = "demo-terragrunt"
}