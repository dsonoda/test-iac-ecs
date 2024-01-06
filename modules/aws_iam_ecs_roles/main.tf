#########
# AWS IAM ECS task role module
#########

# policy document
## principal
data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

## ECS Exec
data "aws_iam_policy_document" "ecs_exec" {
  count = var.enable_ecs_exec ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]

    resources = [
      "*"
    ]
  }
}

# policy
## ECS Exec
resource "aws_iam_policy" "ecs_exec" {
  count = var.enable_ecs_exec ? 1 : 0

  name        = format("%s-ecs-exec", var.prefix)
  description = "ECS Exec policy"

  policy = data.aws_iam_policy_document.ecs_exec[count.index].json

  tags = merge(var.common_tags, ({
    "Name" : format("%s-ecs-exec", var.prefix)
  }))
}

# role
## ECS task
resource "aws_iam_role" "ecs_task" {
  name        = format("%s-ecs-task", var.prefix)
  description = "ECS task role"

  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json

  tags = merge(var.common_tags, ({
    "Name" : format("%s-ecs-task", var.prefix)
  }))
}

## ECS task exec
resource "aws_iam_role" "ecs_task_exec" {
  name        = format("%s-ecs-task-exec", var.prefix)
  description = "ECS task exec role"

  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json

  tags = merge(var.common_tags, ({
    "Name" : format("%s-ecs-task-exec", var.prefix)
  }))
}

# role policy attachment
## ECS task
### ECS Exec
resource "aws_iam_role_policy_attachment" "ecs_exec_to_ecs_task" {
  count = var.enable_ecs_exec ? 1 : 0

  role       = aws_iam_role.ecs_task.name
  policy_arn = aws_iam_policy.ecs_exec[count.index].arn
}

## ECS task exec
### AmazonECSTaskExecutionRolePolicy
resource "aws_iam_role_policy_attachment" "ecs_task_exec_to_ecs_task_exec" {
  role       = aws_iam_role.ecs_task_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
