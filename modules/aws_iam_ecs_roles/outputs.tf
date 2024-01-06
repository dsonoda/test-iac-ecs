output "ecs_task_role_name" {
  value = aws_iam_role.ecs_task.name
}

output "ecs_task_exec_role_name" {
  value = aws_iam_role.ecs_task_exec.name
}
