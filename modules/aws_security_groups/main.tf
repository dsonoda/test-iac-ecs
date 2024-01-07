#########
# AWS security group
#########

# ALB
resource "aws_security_group" "alb" {
  name        = "${var.prefix}-alb-sg"
  description = "${var.prefix}-alb-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-alb-sg"
  }))
}

resource "aws_security_group_rule" "alb_from_http_access" {
  description              = "ALB from HTTP access"
  type                     = "ingress"
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = null
  cidr_blocks              = ["0.0.0.0/0"]
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
}

resource "aws_security_group_rule" "alb_from_https_access" {
  description              = "ALB from HTTPS access"
  type                     = "ingress"
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = null
  cidr_blocks              = ["0.0.0.0/0"]
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
}

resource "aws_security_group_rule" "alb_to_ecs" {
  description              = "ALB to ECS"
  type                     = "egress"
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = aws_security_group.ecs.id
  cidr_blocks              = null
  protocol                 = "tcp"
  from_port                = var.alb_to_ecs_port
  to_port                  = var.alb_to_ecs_port
}

# ECS
resource "aws_security_group" "ecs" {
  name        = "${var.prefix}-ecs-sg"
  description = "${var.prefix}-ecs-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-ecs-sg"
  }))
}

resource "aws_security_group_rule" "ecs_from_alb" {
  description              = "ECS from ALB"
  type                     = "ingress"
  security_group_id        = aws_security_group.ecs.id
  source_security_group_id = aws_security_group.alb.id
  cidr_blocks              = null
  protocol                 = "tcp"
  from_port                = var.alb_to_ecs_port
  to_port                  = var.alb_to_ecs_port
}

resource "aws_security_group_rule" "ecs_to_vpc_endpoint" {
  description              = "ECS to VPC endpoint"
  type                     = "egress"
  security_group_id        = aws_security_group.ecs.id
  source_security_group_id = null
  cidr_blocks              = ["0.0.0.0/0"]
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
}

resource "aws_security_group_rule" "ecs_to_rds" {
  description              = "ECS to RDS"
  type                     = "egress"
  security_group_id        = aws_security_group.ecs.id
  source_security_group_id = aws_security_group.rds.id
  cidr_blocks              = null
  protocol                 = "tcp"
  from_port                = var.rds_port
  to_port                  = var.rds_port
}

resource "aws_security_group_rule" "ecs_to_efs" {
  description              = "ECS to EFS"
  type                     = "egress"
  security_group_id        = aws_security_group.ecs.id
  source_security_group_id = aws_security_group.efs.id
  cidr_blocks              = null
  protocol                 = "tcp"
  from_port                = 2049
  to_port                  = 2049
}

# RDS
resource "aws_security_group" "rds" {
  name        = "${var.prefix}-rds-sg"
  description = "${var.prefix}-rds-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-rds-sg"
  }))
}

resource "aws_security_group_rule" "rds_from_vpc" {
  description              = "RDS from VPC"
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = null
  cidr_blocks              = [var.vpc_cidr_block] # from ECS & bastion
  protocol                 = "tcp"
  from_port                = var.rds_port
  to_port                  = var.rds_port
}

# VPC Endpoint
resource "aws_security_group" "vpce" {
  name        = "${var.prefix}-vpce-sg"
  description = "${var.prefix}-vpce-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-vpce-sg"
  }))
}

resource "aws_security_group_rule" "vpc_endpoint_to_443" {
  description              = "VPC endpoint to 443"
  type                     = "egress"
  security_group_id        = aws_security_group.vpce.id
  source_security_group_id = null
  cidr_blocks              = ["0.0.0.0/0"]
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
}

# bastion EC2 instance
resource "aws_security_group" "bastion" {
  name        = "${var.prefix}-bastion-sg"
  description = "${var.prefix}-bastion-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-bastion-sg"
  }))
}

resource "aws_security_group_rule" "bastion_to_efs_rds" {
  description              = "bastion to EFS, RDS, and in curl exec on EC2 instance userdata scripts"
  type                     = "egress"
  security_group_id        = aws_security_group.bastion.id
  source_security_group_id = null
  cidr_blocks              = ["0.0.0.0/0"]
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
}

# EFS
resource "aws_security_group" "efs" {
  name        = "${var.prefix}-efs-sg"
  description = "${var.prefix}-efs-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-efs-sg"
  }))
}

resource "aws_security_group_rule" "efs_from_ecs" {
  description              = "EFS from ECS"
  type                     = "ingress"
  security_group_id        = aws_security_group.efs.id
  source_security_group_id = aws_security_group.ecs.id
  cidr_blocks              = null
  protocol                 = "tcp"
  from_port                = 2049
  to_port                  = 2049
}

resource "aws_security_group_rule" "efs_from_bastion" {
  description              = "EFS from bastion"
  type                     = "ingress"
  security_group_id        = aws_security_group.efs.id
  source_security_group_id = aws_security_group.bastion.id
  cidr_blocks              = null
  protocol                 = "tcp"
  from_port                = 2049
  to_port                  = 2049
}
