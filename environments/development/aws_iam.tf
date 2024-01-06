# generate iam_ecs_task_role
module "iam_ecs_task_role" {
  source = "../../modules/aws_iam_ecs_roles"

  region = local.region

  prefix = local.service_name

  common_tags = local.common_tags

  enable_ecs_exec = local.enable_ecs_exec
}

# attach poliry to iam_ecs_task_role
## Secrets Manager
