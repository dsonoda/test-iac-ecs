output "ecs_task_role_name" {
  value = aws_iam_role.ecs_task.name
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "ecs_task_exec_role_name" {
  value = aws_iam_role.ecs_task_exec.name
}

output "ecs_task_exec_role_arn" {
  value = aws_iam_role.ecs_task_exec.arn
}
