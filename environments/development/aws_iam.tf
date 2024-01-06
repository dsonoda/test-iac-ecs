# generate iam ecs task role & ecs task exec role
module "iam_ecs_task_roles" {
  source = "../../modules/aws_iam_ecs_roles"

  region      = local.region
  prefix      = local.service_name
  common_tags = local.common_tags
}

# attach poliry to iam ecs task role
## Secrets Manager


# attach poliry to iam ecs task exec role
