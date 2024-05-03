include {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/aws-elasticache"
}

terraform {
  source = local.base_source
}

dependency "security_groups" {
  config_path = "../security_groups"
}

inputs = {
  replication_group_id       = "TF-SoftPOS-Prod"
  engine_version             = "7.1"
  node_type                  = "cache.m5.large"
  cluster_mode_enabled       = true
  description                = "SoftPOS Redis Cluster"
  num_node_groups            = 3
  replicas_per_node_group    = 1
  automatic_failover_enabled = true
  multi_az_enabled           = true
  maintenance_window         = "sun:09:00-sun:10:00"
  apply_immediately          = true
  security_group_ids         = [dependency.security_groups.outputs.security_group_id]
  transit_encryption_enabled = true
  transit_encryption_mode    = "required"
  auth_token                 = "AFSRedisProdSoftPOS"
  at_rest_encryption_enabled = true
  subnet_ids                 = ["subnet-0dfaa7142a9c27bae", "subnet-0b4daadf19aeb3cb1", "subnet-0f56a96d7aa59f42d"]
  subnet_group_name          = "TF-SoftPOS-Prod"
  create_security_group      = false
  snapshot_retention_limit   = 7
  snapshot_window            = "07:00-08:00"
}
