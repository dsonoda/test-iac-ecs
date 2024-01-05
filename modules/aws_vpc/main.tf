#########
# AWS VPC network module
#########

# VPC
resource "aws_vpc" "mod" {
  cidr_block           = var.vpc.cidr_block
  enable_dns_hostnames = var.vpc.enable_dns_hostnames
  enable_dns_support   = var.vpc.enable_dns_support

  tags = merge(var.common_tags, ({
    "Name" : var.prefix
  }))
}

# public subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.mod.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(var.common_tags, ({
    "Name" : format("%s-public-%s", var.prefix, element(var.availability_zones, count.index))
  }))
}

# private subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.mod.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = merge(var.common_tags, ({
    "Name" : format("%s-private-%s", var.prefix, element(var.availability_zones, count.index))
  }))
}

# private subnet
resource "aws_subnet" "private_db" {
  count = length(var.private_db_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.mod.id
  cidr_block              = var.private_db_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = merge(var.common_tags, ({
    "Name" : format("%s-private-db-%s", var.prefix, element(var.availability_zones, count.index))
  }))
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  count = length(var.public_subnet_cidr_blocks) > 0 ? 1 : 0

  vpc_id = aws_vpc.mod.id

  tags = merge(var.common_tags, ({
    "Name" : format("%s-igw", var.prefix)
  }))
}

# nat gateway
resource "aws_eip" "nateip" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.availability_zones)) : 0

  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.availability_zones)) : 0

  allocation_id = element(aws_eip.nateip.*.id, (var.single_nat_gateway ? 0 : count.index))
  subnet_id     = element(aws_subnet.public.*.id, (var.single_nat_gateway ? 0 : count.index))

  depends_on = [aws_internet_gateway.igw]

  tags = merge(var.common_tags, ({
    "Name" : format("%s-natgw-%s", var.prefix, count.index + 1)
  }))
}

# public route table
resource "aws_route_table" "public" {
  count = length(var.public_subnet_cidr_blocks) > 0 ? 1 : 0

  vpc_id = aws_vpc.mod.id

  tags = merge(var.common_tags, ({
    "Name" : format("%s-public-%s", var.prefix, count.index + 1)
  }))
}

resource "aws_route" "public_internet_gateway" {
  count = length(var.public_subnet_cidr_blocks) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[count.index].id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}

# private route table
resource "aws_route_table" "private" {
  count = var.single_nat_gateway ? 1 : length(var.availability_zones)

  vpc_id = aws_vpc.mod.id

  tags = merge(var.common_tags, ({
    "Name" : format("%s-private-%s", var.prefix, count.index + 1)
  }))
}

resource "aws_route" "private_nat_gateway" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.availability_zones)) : 0

  route_table_id         = var.single_nat_gateway ? aws_route_table.private[0].id : element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.single_nat_gateway ? aws_nat_gateway.natgw[0].id : element(aws_nat_gateway.natgw.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_blocks)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = var.single_nat_gateway ? aws_route_table.private[0].id : element(aws_route_table.private.*.id, count.index)
}

# private db route table
resource "aws_route_table" "private_db" {
  count = var.single_nat_gateway ? 1 : length(var.availability_zones)

  vpc_id = aws_vpc.mod.id

  tags = merge(var.common_tags, ({
    "Name" : format("%s-private-db-%s", var.prefix, count.index + 1)
  }))
}

resource "aws_route" "private_db_nat_gateway" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.availability_zones)) : 0

  route_table_id         = var.single_nat_gateway ? aws_route_table.private_db[0].id : element(aws_route_table.private_db.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.single_nat_gateway ? aws_nat_gateway.natgw[0].id : element(aws_nat_gateway.natgw.*.id, count.index)
}

resource "aws_route_table_association" "private_db" {
  count = length(var.private_db_subnet_cidr_blocks)

  subnet_id      = element(aws_subnet.private_db.*.id, count.index)
  route_table_id = var.single_nat_gateway ? aws_route_table.private_db[0].id : element(aws_route_table.private_db.*.id, count.index)
}
