terraform {
  #source = "${local.source_base_url}//iam/role?ref=iam-role-v0.1.1"
  source = "${get_repo_root()}/../terraform-modules//iam/role"
}

locals {
  source_base_url = "git@github.com:vladmalynych/devops-edu.git"
}

inputs = {

}
