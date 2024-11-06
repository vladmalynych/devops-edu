terraform {
  source = "../../../../../tf-modules//ec2/"
}

include "root" {
  path = find_in_parent_folders()
}


dependency "sg" {
  config_path = "../sg/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    security_group_id = "fake-security-group-id"
  }
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
  ami = "ami-0f3a22468a3535271"
  instance_type = "t3.micro"
  instance_name = "demo-terragrunt-ec2"
  subnet_id = dependency.vpc.outputs.private_subnets[0]
  security_group_ids = [dependency.sg.outputs.security_group_id]
}