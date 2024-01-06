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

variable "enable_ecs_exec" {
  description = "Whether to enable ECS Exec functionality"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "list of security group ids"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "list of subnet ids"
  type        = list(string)
  default     = []
}

variable "vpc_endpoint_interface_settings" {
  description = "type interface vpc endpoint settings"
  type = list(object({
    is_ecs_exec_rsc     = bool
    vpce_name           = string
    private_dns_enabled = bool
  }))
  default = [
    {
      is_ecs_exec_rsc     = false
      vpce_name           = "",
      private_dns_enabled = false
    }
  ]
}

variable "vpc_endpoint_gateway_settings" {
  description = "type gateway vpc endpoint settings"
  type = list(object({
    vpce_name                = string
    associate_route_table_id = string
  }))
  default = [
    {
      vpce_name                = "",
      associate_route_table_id = ""
    }
  ]
}
