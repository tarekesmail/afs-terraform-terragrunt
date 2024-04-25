include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/aws-security-group"
}

terraform {
  source = local.base_source
}

inputs = {
  name   = "SG-VISIONFLEX-BH5VFSTGSIT01"
  vpc_id = "vpc-0f20c8a4e0e438497"
  ingress_rules = {
    "22/tcp" = {
      sources     = ["10.10.0.0/16","10.71.0.0/16","168.87.158.102/32","168.87.158.101/32"]
      description = "allow ingress SSH"
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
