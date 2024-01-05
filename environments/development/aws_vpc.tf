module "vpc" {
  source = "../../modules/aws_vpc"

  prefix = local.service_name

  common_tags = local.common_tags

  vpc = {
    cidr_block           = "192.168.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
  }

  availability_zones = [
    "${local.region}c",
    "${local.region}d"
  ]

  # public subnet
  map_public_ip_on_launch = true

  public_subnet_cidr_blocks = [
    "192.168.0.0/24",
    "192.168.1.0/24"
  ]

  private_subnet_cidr_blocks = [
    "192.168.2.0/24",
    "192.168.3.0/24"
  ]

  private_db_subnet_cidr_blocks = [
    "192.168.4.0/24",
    "192.168.5.0/24"
  ]

  create_db_subnet_group = true

  enable_nat_gateway = true

  # Whether to create just one NAT Gateway or not.
  single_nat_gateway = true

}
