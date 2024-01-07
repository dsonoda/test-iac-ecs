variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

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

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = ""
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type        = string
  default     = ""
}

variable "alb_to_ecs_port" {
  description = "alb to ecs port"
  type        = number
  default     = 80
}

variable "rds_port" {
  description = "rds port"
  type        = number
  default     = 5432
}
