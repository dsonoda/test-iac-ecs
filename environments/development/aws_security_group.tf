locals {
  alb_to_ecs_port = 80
  rds_port        = 5432
}

module "security_group" {
  source = "../../modules/aws_security_groups"

  region      = local.region
  prefix      = local.service_name
  common_tags = local.common_tags
  vpc_id      = module.vpc.vpc_id
}

module "security_group_rules" {
  source = "../../modules/aws_security_group_rules"

  region      = local.region
  prefix      = local.service_name
  common_tags = local.common_tags

  security_group_rules = [
    # ALB
    {
      description              = "ALB from HTTP access"
      type                     = "ingress"
      security_group_id        = module.security_group.security_group_alb_id
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      protocol                 = "tcp"
      from_port                = 80
      to_port                  = 80
    },
    {
      description              = "ALB from HTTPS access"
      type                     = "ingress"
      security_group_id        = module.security_group.security_group_alb_id
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
    },
    {
      description              = "ALB to ECS"
      type                     = "egress"
      security_group_id        = module.security_group.security_group_alb_id
      source_security_group_id = module.security_group.security_group_ecs_id
      cidr_blocks              = null
      protocol                 = "tcp"
      from_port                = local.alb_to_ecs_port
      to_port                  = local.alb_to_ecs_port
    },
    # ECS
    {
      description              = "ECS from ALB"
      type                     = "ingress"
      security_group_id        = module.security_group.security_group_ecs_id
      source_security_group_id = module.security_group.security_group_alb_id
      cidr_blocks              = null
      protocol                 = "tcp"
      from_port                = local.alb_to_ecs_port
      to_port                  = local.alb_to_ecs_port
    },
    {
      description              = "ECS to VPC endpoint"
      type                     = "egress"
      security_group_id        = module.security_group.security_group_ecs_id
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
    },
    {
      description              = "ECS to RDS"
      type                     = "egress"
      security_group_id        = module.security_group.security_group_ecs_id
      source_security_group_id = module.security_group.security_group_rds_id
      cidr_blocks              = null
      protocol                 = "tcp"
      from_port                = local.rds_port
      to_port                  = local.rds_port
    },
    # RDS
    {
      description              = "RDS from VPC"
      type                     = "ingress"
      security_group_id        = module.security_group.security_group_rds_id
      source_security_group_id = null
      cidr_blocks              = [module.vpc.vpc_cidr_block] # from ECS & bastion
      protocol                 = "tcp"
      from_port                = local.rds_port
      to_port                  = local.rds_port
    },
    # VPC endpoint
    {
      description              = "VPC endpoint to 443"
      type                     = "egress"
      security_group_id        = module.security_group.security_group_vpce_id
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
    }
  ]

  # Ingress settings is not set here because the developer's IP address is set manually from the Managed Console.
  security_group_bastion_rules = [
    {
      description              = "bastion to EFS, RDS, and in curl exec on EC2 instance userdata scripts."
      type                     = "egress"
      security_group_id        = module.security_group.security_group_bastion_id
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      protocol                 = "-1"
      from_port                = 0
      to_port                  = 0
    }
  ]

  security_group_efs_rules = [
    {
      description              = "ECS to EFS"
      type                     = "egress"
      security_group_id        = module.security_group.security_group_ecs_id
      source_security_group_id = module.security_group.security_group_efs_id
      cidr_blocks              = null
      protocol                 = "tcp"
      from_port                = 2049
      to_port                  = 2049
    },
    {
      description              = "EFS from ECS"
      type                     = "ingress"
      security_group_id        = module.security_group.security_group_efs_id
      source_security_group_id = module.security_group.security_group_ecs_id
      cidr_blocks              = null
      protocol                 = "tcp"
      from_port                = 2049
      to_port                  = 2049
    },
    {
      description              = "EFS from bastion"
      type                     = "ingress"
      security_group_id        = module.security_group.security_group_efs_id
      source_security_group_id = module.security_group.security_group_bastion_id
      cidr_blocks              = null
      protocol                 = "tcp"
      from_port                = 2049
      to_port                  = 2049
    }
  ]
}
