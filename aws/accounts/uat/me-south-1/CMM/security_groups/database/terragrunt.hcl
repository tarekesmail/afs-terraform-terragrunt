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
  name   = "SG-CMM-BH5CMMPGSVMUT01"
  vpc_id = "vpc-0390fe94c7c1c98ab"
  ingress_rules = {
    "5432/tcp" = {
      sources     = ["10.71.24.96/27"]
      description = "allow ingress Postgres from App Servers"
    }
    "22/tcp" = {
      sources     = ["10.10.140.0/24", "10.10.180.0/24"]
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
