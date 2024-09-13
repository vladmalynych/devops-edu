terraform {
  #source = "${local.source_base_url}//terragrunt/tf-modules/s3?ref=s3-v0.0.1"
  source = "${get_repo_root()}//terragrunt/tf-modules/s3"
}

locals {
  # Source URL for EDU terraform modules. Clones the repo over SSH.
  source_base_url = "git@github.com:vladmalynych/devops-edu.git"
}

inputs = {}
