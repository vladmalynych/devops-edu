# backend.tf
terraform {
  backend "s3" {
    bucket  = "devops-edu-terraform-state"
    key     = "demo-terragrunt/tf/ec2/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
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
data "aws_security_group" "sg" {
  filter {
    name = "tag:Name"
    values = ["demo-terraform-sg"]
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "devops-edu-terraform-state"
    key    = "demo-terragrunt/tf/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "ec2" {
  source            = "../../tf-modules/ec2/"

  ami = "ami-0f3a22468a3535271"
  instance_type = "t3.micro"
  instance_name = "demo-terraform-ec2"
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  security_group_ids = [data.aws_security_group.sg.id]
}