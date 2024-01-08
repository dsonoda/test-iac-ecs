# generate iam ecs task role & ecs task exec role
module "iam_ecs_task_roles" {
  source = "../../modules/aws_iam_ecs_roles"

  region      = local.region
  prefix      = local.service_name
  common_tags = local.common_tags
}

# policy
resource "aws_iam_policy" "read_secrets_manager" {
  name        = format("%s-read-secrets-manager", local.service_name)
  description = "Read Secrets Manager policy"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "kms:Decrypt"
        ]
        Resource = [
          aws_db_instance.db_1.master_user_secret.0.secret_arn
        ]
      }
    ]
  })

  tags = merge(local.common_tags, ({
    "Name" : format("%s-read-secrets-manager", local.service_name)
  }))
}

# attach poliry to iam ecs task role
## read secrets manager
resource "aws_iam_role_policy_attachment" "read_secrets_manager_to_ecs_task" {
  role       = module.iam_ecs_task_roles.ecs_task_role_name
  policy_arn = aws_iam_policy.read_secrets_manager.arn
}

# attach poliry to iam ecs task exec role
## read secrets manager
resource "aws_iam_role_policy_attachment" "read_secrets_manager_to_ecs_task_exec" {
  role       = module.iam_ecs_task_roles.ecs_task_exec_role_name
  policy_arn = aws_iam_policy.read_secrets_manager.arn
}
