#########
# AWS security group rules
#########

# generate rules
resource "aws_security_group_rule" "mod" {
  count = length(var.security_group_rules)

  description              = var.security_group_rules[count.index].description
  type                     = var.security_group_rules[count.index].type
  security_group_id        = var.security_group_rules[count.index].security_group_id
  source_security_group_id = var.security_group_rules[count.index].source_security_group_id
  cidr_blocks              = var.security_group_rules[count.index].cidr_blocks
  protocol                 = var.security_group_rules[count.index].protocol
  from_port                = var.security_group_rules[count.index].from_port
  to_port                  = var.security_group_rules[count.index].to_port
}

resource "aws_security_group_rule" "for_bastion" {
  count = length(var.security_group_bastion_rules)

  description              = var.security_group_bastion_rules[count.index].description
  type                     = var.security_group_bastion_rules[count.index].type
  security_group_id        = var.security_group_bastion_rules[count.index].security_group_id
  source_security_group_id = var.security_group_bastion_rules[count.index].source_security_group_id
  cidr_blocks              = var.security_group_bastion_rules[count.index].cidr_blocks
  protocol                 = var.security_group_bastion_rules[count.index].protocol
  from_port                = var.security_group_bastion_rules[count.index].from_port
  to_port                  = var.security_group_bastion_rules[count.index].to_port
}

resource "aws_security_group_rule" "for_efs" {
  count = length(var.security_group_efs_rules)

  description              = var.security_group_efs_rules[count.index].description
  type                     = var.security_group_efs_rules[count.index].type
  security_group_id        = var.security_group_efs_rules[count.index].security_group_id
  source_security_group_id = var.security_group_efs_rules[count.index].source_security_group_id
  cidr_blocks              = var.security_group_efs_rules[count.index].cidr_blocks
  protocol                 = var.security_group_efs_rules[count.index].protocol
  from_port                = var.security_group_efs_rules[count.index].from_port
  to_port                  = var.security_group_efs_rules[count.index].to_port
}
