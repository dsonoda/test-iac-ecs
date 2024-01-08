# subnet group
resource "aws_db_subnet_group" "group" {
  count = length(local.private_db_subnet_cidr_blocks) > 0 && local.create_db_subnet_group ? 1 : 0

  name        = "${local.service_name}-rds-subnet-group"
  description = "Database subnet groups for ${local.service_name}"
  subnet_ids  = module.vpc.private_db_subnet_ids

  tags = merge(local.common_tags, ({
    "Name" : "${local.service_name}-rds-subnet-group"
  }))
}

# parameter group
resource "aws_db_parameter_group" "group" {
  name        = "${local.service_name}-db-parameter-group"
  family      = local.db_parameter_group_family
  description = "DB parameter group for ${local.service_name}"
  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }
  tags = merge(local.common_tags, ({
    "Name" : "${local.service_name}-db-parameter-group"
  }))
}

# db instance
resource "aws_db_instance" "db_1" {
  # base
  db_name                     = local.db_instance.db_name
  identifier                  = local.db_instance.identifier
  engine                      = local.db_instance.engine
  engine_version              = local.db_instance.engine_version
  instance_class              = local.db_instance.instance_class
  parameter_group_name        = aws_db_parameter_group.group.name
  storage_encrypted           = local.db_instance.storage_encrypted
  username                    = local.db_instance.username
  manage_master_user_password = true

  # storage
  storage_type          = local.db_instance.storage_type
  allocated_storage     = local.db_instance.allocated_storage
  max_allocated_storage = local.db_instance.max_allocated_storage

  # network
  multi_az               = local.db_instance.multi_az
  db_subnet_group_name   = aws_db_subnet_group.group[0].name
  vpc_security_group_ids = [module.security_groups.security_group_rds_id]
  port                   = local.db_instance.port

  # backup
  backup_window              = local.db_instance.backup_window
  maintenance_window         = local.db_instance.maintenance_window
  backup_retention_period    = local.db_instance.backup_retention_period
  auto_minor_version_upgrade = local.db_instance.auto_minor_version_upgrade
  copy_tags_to_snapshot      = local.db_instance.copy_tags_to_snapshot

  # delete protection
  deletion_protection       = local.db_instance.deletion_protection
  skip_final_snapshot       = local.db_instance.skip_final_snapshot
  final_snapshot_identifier = local.service_name
  apply_immediately         = local.db_instance.apply_immediately

  # monitoring
  performance_insights_enabled          = local.db_instance.performance_insights_enabled
  performance_insights_retention_period = local.db_instance.performance_insights_retention_period

  # log
  enabled_cloudwatch_logs_exports = local.db_instance.enabled_cloudwatch_logs_exports

  # encryption
  kms_key_id = data.aws_kms_key.rds.arn

  # lifecycle
  lifecycle {
    ignore_changes = [
      engine_version,
      allocated_storage,
      apply_immediately,
      skip_final_snapshot,
    ]
  }

  tags = merge(local.common_tags, ({
    "Name" : local.service_name
  }))
}
