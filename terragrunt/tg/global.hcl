# Common global variables for all OUs/accounts/regions/components.
locals {
  project_name = "terragrunt-demo"
  owner_name   = "devops-edu"
  deployment_prefix = "demo-terragrunt"
}

# # Common configurations that can be inherited by other environments
# inputs = {
#   environment = "global"
#   project     = local.project_name
#   owner       = local.owner_name
# }