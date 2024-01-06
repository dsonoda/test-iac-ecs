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

# ECS
resource "aws_security_group" "ecs" {
  name        = "${var.prefix}-ecs-sg"
  description = "${var.prefix}-ecs-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-ecs-sg"
  }))
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

# VPC Endpoint
resource "aws_security_group" "vpce" {
  name        = "${var.prefix}-vpce-sg"
  description = "${var.prefix}-vpce-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-vpce-sg"
  }))
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

# EFS
resource "aws_security_group" "efs" {
  name        = "${var.prefix}-efs-sg"
  description = "${var.prefix}-efs-sg"

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, ({
    "Name" : "${var.prefix}-efs-sg"
  }))
}
