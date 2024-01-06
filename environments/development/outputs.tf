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

output "database_subnet_group" {
  value = module.vpc.database_subnet_group
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
  value = module.iam_ecs_task_role.ecs_task_role_name
}

output "ecs_task_role_arn" {
  value = module.iam_ecs_task_role.ecs_task_role_arn
}

output "ecs_task_exec_role_name" {
  value = module.iam_ecs_task_role.ecs_task_exec_role_name
}

output "ecs_task_exec_role_arn" {
  value = module.iam_ecs_task_role.ecs_task_exec_role_arn
}
