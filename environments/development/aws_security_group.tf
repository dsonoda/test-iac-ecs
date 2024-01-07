module "security_groups" {
  source = "../../modules/aws_security_groups"

  region          = local.region
  prefix          = local.service_name
  common_tags     = local.common_tags
  vpc_id          = module.vpc.vpc_id
  vpc_cidr_block  = module.vpc.vpc_cidr_block
  alb_to_ecs_port = local.alb_to_ecs_port
  rds_port        = local.rds_port
}
