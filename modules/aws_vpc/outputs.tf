output "vpc_id" {
  value = aws_vpc.mod.id
}

output "vpc_cidr_block" {
  value = aws_vpc.mod.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "private_db_subnet_ids" {
  value = aws_subnet.private_db[*].id
}

output "igw_id" {
  value = aws_internet_gateway.igw[*].id
}

output "nat_eips" {
  value = aws_eip.nateip[*].id
}

output "nat_eips_public_ips" {
  value = aws_eip.nateip[*].public_ip
}

output "natgw_ids" {
  value = aws_nat_gateway.natgw[*].id
}

output "public_route_table_ids" {
  value = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  value = aws_route_table.private[*].id
}

output "private_db_route_table_ids" {
  value = aws_route_table.private_db[*].id
}
