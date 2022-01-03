locals {
  resource_name = lower(format("%s_%s_%s",var.resource_identifier,var.environment, var.service))
  common_tags = {
      "Name" = local.resource_name
  }
  cluster_family = 
  cluster_parameter_description = lower(format())
  global_cluster_name = 
}