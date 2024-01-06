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
