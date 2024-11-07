terraform {
  source = "../../../../../tf-modules//vpc/"
}

include "root" {
  path = find_in_parent_folders()
  expose = true
}

inputs = {
  cidr = "10.11.0.0"
  deployment_prefix = include.root.inputs.deployment_prefix
}