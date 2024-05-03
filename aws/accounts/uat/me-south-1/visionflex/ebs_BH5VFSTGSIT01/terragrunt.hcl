include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/ebs-volume"
}

terraform {
  source = local.base_source
}

dependency "ebs_ec2" {
  config_path = "../ec2_BH5VFSTGSIT01"
}


inputs = {
  size                   = 100 
  az                     = "me-south-1a" 
  instance_id            = dependency.ebs_ec2.outputs.id
  device_name            = "/dev/sdf"
}
