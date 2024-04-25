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
  vpc_id            = "vpc-07930a91e648af4ee"
  cidr_block        = "10.72.230.0/27"
  availability_zone = "me-south-1a"
  subnet_name       = "SNET-ACM"
}
