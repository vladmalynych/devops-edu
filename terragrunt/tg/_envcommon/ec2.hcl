terraform {
  #source = "${local.source_base_url}//terragrunt/tf-modules/ec2?ref=ec2-v0.0.1"
  source = "${get_repo_root()}//terragrunt/tf-modules/ec2"
}

locals {
  # Source URL for EDU terraform modules. Clones the repo over SSH.
  source_base_url = "git@github.com:vladmalynych/devops-edu.git"
}

inputs = {}
