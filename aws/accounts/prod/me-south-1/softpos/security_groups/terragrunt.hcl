include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/aws-security-group"
}

terraform {
  source = local.base_source
}

dependency "eks_node_sg" {
  config_path = "../eks"
}

inputs = {
  name   = "TF-BAH-SoftPos-Prod-redis"
  vpc_id = "vpc-0d4e2de3d4ab22aba"
  ingress_rules = {
    "6379/tcp" = {
      sources     = [dependency.eks_node_sg.outputs.eks.node_security_group_id]
      description = "allow ingress Redis"
    }
  }
  egress_rules = {
    "all_tcp" = {
      destinations = ["0.0.0.0/0"]
      description  = "Allow all TCP outbound access"
    }
    "all_udp" = {
      destinations = ["0.0.0.0/0"]
      description  = "Allow all UDP outbound access"
    }
  }
}
