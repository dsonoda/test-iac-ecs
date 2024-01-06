output "security_group_alb_id" {
  value = aws_security_group.alb.id
}

output "security_group_ecs_id" {
  value = aws_security_group.ecs.id
}

output "security_group_rds_id" {
  value = aws_security_group.rds.id
}

output "security_group_vpce_id" {
  value = aws_security_group.vpce.id
}

output "security_group_bastion_id" {
  value = aws_security_group.bastion.id
}

output "security_group_efs_id" {
  value = aws_security_group.efs.id
}
