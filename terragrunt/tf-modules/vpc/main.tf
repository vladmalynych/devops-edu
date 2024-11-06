data "aws_availability_zones" "available" {}

locals {
  cidr_part = trimsuffix(var.cidr, ".0.0")
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"

  name = "${var.deployment_prefix}-VPC"
  cidr = "${var.cidr}/16"

  azs = data.aws_availability_zones.available.names
  private_subnets = ["${local.cidr_part}.1.0/24", "${local.cidr_part}.2.0/24", "${local.cidr_part}.3.0/24"]
  public_subnets = ["${local.cidr_part}.21.0/24", "${local.cidr_part}.22.0/24", "${local.cidr_part}.23.0/24"]

  # Avoid creating billable components
  enable_nat_gateway = false           # NAT Gateways are chargeable
  enable_vpn_gateway = false           # VPN Gateway is chargeable
}