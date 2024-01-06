variable "prefix" {
  description = "resource name prefix"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Service     = ""
    Environment = ""
    Provisioner = "terraform"
  }
}

variable "vpc" {
  description = "VPC settings"
  type        = map(string)
  default = {
    cidr                 = ""
    enable_dns_hostnames = ""
    enable_dns_support   = ""
  }
}

variable "availability_zones" {
  description = "list of availability_zones"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  type        = bool
  default     = true
}

variable "public_subnet_cidr_blocks" {
  description = "list of public subnet cidr blocks"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidr_blocks" {
  description = "list of private subnet cidr blocks"
  type        = list(string)
  default     = []
}

variable "private_db_subnet_cidr_blocks" {
  description = "list of private db subnet cidr blocks"
  type        = list(string)
  default     = []
}

variable "create_db_subnet_group" {
  description = "Controls, if should database subnet group be created."
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}
