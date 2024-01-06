locals {
  service_name = "test-iac-ecs"
  Environment  = "development"
  region       = "ap-northeast-1"

  common_tags = {
    Service     = local.service_name
    Environment = local.Environment
    Provisioner = "terraform"
  }

  # ECS Exec
  enable_ecs_exec = true

}
