# backend.tf
terraform {
  backend "s3" {
    bucket  = "devops-edu-terraform-state"
    key     = "demo-terragrunt/tf/sg/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}

# versions.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      "Project" = "EDU",
    }
  }
}

# main.tf
data "aws_vpc" "vpc" {
  filter {
    name = "tag:Name"
    values = ["demo-terraform-VPC"]
  }
}

module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "demo-terraform-sg"
  description = "Security group for EC2 instance"
  vpc_id      = data.aws_vpc.vpc.id

  ingress_with_cidr_blocks = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "10.10.0.0/16"
    },
  ]
}