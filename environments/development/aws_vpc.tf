module "vpc" {
  source = "../../modules/aws_vpc"

  prefix      = local.service_name
  common_tags = local.common_tags

  vpc = {
    cidr_block           = local.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support   = true
  }

  availability_zones = [
    "${local.region}c",
    "${local.region}d"
  ]

  # public subnet
  map_public_ip_on_launch = true

  public_subnet_cidr_blocks = local.public_subnet_cidr_blocks

  private_subnet_cidr_blocks = local.private_subnet_cidr_blocks

  private_db_subnet_cidr_blocks = local.private_db_subnet_cidr_blocks

  enable_nat_gateway = true

  # Whether to create just one NAT Gateway or not.
  single_nat_gateway = true
}

module "vpc_endpoints" {
  source = "../../modules/aws_vpc_endpoints"

  region      = local.region
  prefix      = local.service_name
  common_tags = local.common_tags

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.security_group_vpce_id]

  enable_ecs_exec = local.enable_ecs_exec

  vpc_endpoint_interface_settings = [
    {
      is_ecs_exec_rsc     = true,
      vpce_name           = "ssmmessages",
      private_dns_enabled = true
    },
    {
      is_ecs_exec_rsc     = true,
      vpce_name           = "ssm",
      private_dns_enabled = true
    },
    {
      is_ecs_exec_rsc     = false,
      vpce_name           = "ecr.dkr",
      private_dns_enabled = true
    },
    {
      is_ecs_exec_rsc     = false,
      vpce_name           = "ecr.api",
      private_dns_enabled = true
    },
    {
      is_ecs_exec_rsc     = false,
      vpce_name           = "secretsmanager",
      private_dns_enabled = true
    },
    {
      is_ecs_exec_rsc     = false,
      vpce_name           = "logs",
      private_dns_enabled = true
    }
  ]

  vpc_endpoint_gateway_settings = [
    {
      vpce_name                = "s3",
      associate_route_table_id = module.vpc.private_route_table_ids[0]
    }
  ]
}
