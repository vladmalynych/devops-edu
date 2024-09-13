include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/iam-role.hcl"
}

dependency "s3" {
  config_path = "${get_terragrunt_dir()}/../s3"
  mock_outputs = {
    role_policy_arn = "arn:aws:iam::123456789012:policy/dummy-policy-name"
    app_name        = "dummy-app"
  }
}

inputs = {
  role_policy_arns                     = [dependency.s3.outputs.role_policy_arn]
}
