resource "aws_db_subnet_group" "default" {
  name = local.resource_name
  subnet_ids = var.subnet
  tags = local.common_tags
  
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_rds_cluster_parameter_group" "default" {
  name = local.resource_name
  family = local.cluster_family
  dynamic "parameter" {
    for_each = local.clusterparameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name = parameter.value.name
      value = parameter.value.value
    }
  }
  description = local.cluster_parameter_description
  tags = local.common_tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_rds_global_cluster" "default" {
  global_cluster_identifier = local.global_cluster_name
  deletion_protection = lookup(var.db_cluster, "deletion_protection", "false")
  source_db_cluster_identifier = aws_rds_cluster.default.arn
  force_destroy = lookup(var.db_cluster, "force_destroy", "false")
  lifecycle {
    ignore_changes = [source_db_cluster_identifier]
  }
  depends_on = [ aws_rds_cluster.default ]
}
resource "aws_rds_cluster" "default" {
  cluster_identifier = local.cluster_name
  database_name   = lookup(var.db_cluster, "database_name", "")
  master_password = lookup(var.db_cluster, "master_password", "")
  master_username = lookup(var.db_cluster, "master_username", "")
  final_snapshot_identifier = lower(format("%s_final_snapshot", local.clustername))
  skip_final_snapshot = lookup(var.db_cluster, "skip_final_snapshot", false)
  preferred_backup_window = lookup(var.db_cluster, "preferred_maintenance_window", "sun:05:00-sun:06:00")
  port = lookup(var.db_cluster, "port", "3306")
  vpc_security_group_ids  = split(",", var.db_cluster["security_groups"])
  snapshot_identifier = lookup(var.db_cluster_parameter_group_name
  
}