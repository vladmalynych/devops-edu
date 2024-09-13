module "this" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.32.0"

  create_role                    = true
  role_name                      = "eks-${var.environment}-${var.role_name}"
  role_policy_arns               = var.role_policy_arns
}
