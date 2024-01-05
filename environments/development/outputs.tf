### aws_vpc outputs

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
