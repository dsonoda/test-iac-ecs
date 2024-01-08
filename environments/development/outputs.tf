# aws_vpc outputs

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "nat_eips" {
  value = module.vpc.nat_eips
}

output "nat_eips_public_ips" {
  value = module.vpc.nat_eips_public_ips
}

output "natgw_ids" {
  value = module.vpc.natgw_ids
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "private_db_route_table_ids" {
  value = module.vpc.private_db_route_table_ids
}

# aws_iam outputs
output "ecs_task_role_name" {
  value = module.iam_ecs_task_roles.ecs_task_role_name
}

output "ecs_task_role_arn" {
  value = module.iam_ecs_task_roles.ecs_task_role_arn
}

output "ecs_task_exec_role_name" {
  value = module.iam_ecs_task_roles.ecs_task_exec_role_name
}

output "ecs_task_exec_role_arn" {
  value = module.iam_ecs_task_roles.ecs_task_exec_role_arn
}

output "security_group_alb_id" {
  value = module.security_groups.security_group_alb_id
}

output "security_group_ecs_id" {
  value = module.security_groups.security_group_ecs_id
}

output "security_group_rds_id" {
  value = module.security_groups.security_group_rds_id
}

output "security_group_vpce_id" {
  value = module.security_groups.security_group_vpce_id
}

output "security_group_bastion_id" {
  value = module.security_groups.security_group_bastion_id
}

output "security_group_efs_id" {
  value = module.security_groups.security_group_efs_id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.group[0].name
}

output "db_parameter_group_name" {
  value = aws_db_parameter_group.group.name
}

output "db_1_hostname" {
  value = aws_db_instance.db_1.address
}

output "db_1_name" {
  value = aws_db_instance.db_1.db_name
}

output "db_1_master_user_secret_arn" {
  value = aws_db_instance.db_1.master_user_secret.0.secret_arn
}
