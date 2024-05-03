include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/subnets"
}

terraform {
  source = local.base_source
}

inputs = {
  vpc_id            = "vpc-0390fe94c7c1c98ab"
  cidr_block        = "10.71.24.96/27"
  availability_zone = "me-south-1a"
  subnet_name       = "SNET-CMM-A"
}
