# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.

locals {
  environment   = "dev"

  cidr = "10.11.0.0/16"
  secondary_cidr_blocks = [
    "10.1.0.0/18",
    "10.1.64.0/18",
  ]
  azs = [
    "eu-central-1a",
    "eu-central-1b",
  ]
  private_subnets = [
    "10.1.0.0/18",
    "10.1.64.0/18",
  ]
  public_subnets = [
    "10.11.0.0/24",
    "10.11.64.0/24",
  ]
}
