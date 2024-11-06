# backend.tf
terraform {
  backend "s3" {
    bucket         = "devops-edu-terraform-state"
    key            = "demo-terragrunt/tf/vpc/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}

# versions.tf
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      "Project" = "EDU",
    }
  }
}

# main.tf
module "demo_vpc" {
  source            = "../../tf-modules/vpc/"
  cidr              = "10.10.0.0"
  deployment_prefix = "demo-terraform"
}

# outputs.tf
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.demo_vpc.private_subnets
}