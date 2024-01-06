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

variable "security_group_rules" {
  description = ""
  type = list(object({
    description              = string
    type                     = string
    security_group_id        = string
    source_security_group_id = string
    cidr_blocks              = list(string)
    protocol                 = string
    from_port                = number
    to_port                  = number
  }))
  default = [
    {
      description              = ""
      type                     = ""
      security_group_id        = ""
      source_security_group_id = ""
      cidr_blocks              = []
      protocol                 = ""
      from_port                = null
      to_port                  = null
    }
  ]
}

variable "security_group_bastion_rules" {
  description = ""
  type = list(object({
    description              = string
    type                     = string
    security_group_id        = string
    source_security_group_id = string
    cidr_blocks              = list(string)
    protocol                 = string
    from_port                = number
    to_port                  = number
  }))
  default = [
    {
      description              = ""
      type                     = ""
      security_group_id        = ""
      source_security_group_id = ""
      cidr_blocks              = []
      protocol                 = ""
      from_port                = null
      to_port                  = null
    }
  ]
}

variable "security_group_efs_rules" {
  description = ""
  type = list(object({
    description              = string
    type                     = string
    security_group_id        = string
    source_security_group_id = string
    cidr_blocks              = list(string)
    protocol                 = string
    from_port                = number
    to_port                  = number
  }))
  default = [
    {
      description              = ""
      type                     = ""
      security_group_id        = ""
      source_security_group_id = ""
      cidr_blocks              = []
      protocol                 = ""
      from_port                = null
      to_port                  = null
    }
  ]
}
