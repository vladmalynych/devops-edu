terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-security-group.git//.?ref=v5.2.0"
}

include "root" {
  path = find_in_parent_folders()
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68.0"
    }
  }
}
EOF
}

dependency "vpc" {
  config_path = "../vpc/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    vpc_id         = "vpc-fake-id"
    vpc_cidr_block = "10.0.0.0/16"
  }
}

inputs = {
  name        = "demo-terraform-sg"
  description = "Security group for EC2 instance"
  vpc_id      = dependency.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = dependency.vpc.outputs.vpc_cidr_block
    },
  ]

}