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
