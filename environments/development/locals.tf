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

  alb_to_ecs_port = 80

  rds_port = 5432

  # VPC
  vpc_cidr_block = "192.168.0.0/16"

  public_subnet_cidr_blocks = [
    "192.168.0.0/24",
    "192.168.1.0/24"
  ]

  private_subnet_cidr_blocks = [
    "192.168.2.0/24",
    "192.168.3.0/24"
  ]

  private_db_subnet_cidr_blocks = [
    "192.168.4.0/24",
    "192.168.5.0/24"
  ]

  create_db_subnet_group    = true
  db_parameter_group_family = "postgres15"
  db_instance = {
    db_name                               = replace(local.service_name, "-", "_")
    identifier                            = replace(local.service_name, "_", "-")
    engine                                = "postgres"
    engine_version                        = "15.3"
    instance_class                        = "db.t3.micro"
    storage_encrypted                     = true
    username                              = "postgres"
    storage_type                          = "gp3"
    allocated_storage                     = 20
    max_allocated_storage                 = 100
    multi_az                              = true
    port                                  = 5432
    backup_window                         = "04:00-04:30"
    maintenance_window                    = "Mon:04:30-Mon:06:00"
    backup_retention_period               = 7
    auto_minor_version_upgrade            = false
    copy_tags_to_snapshot                 = true
    deletion_protection                   = true
    skip_final_snapshot                   = false
    apply_immediately                     = false
    performance_insights_enabled          = true
    performance_insights_retention_period = 7
    enabled_cloudwatch_logs_exports = [
      "postgresql",
      "upgrade"
    ]
  }
}
