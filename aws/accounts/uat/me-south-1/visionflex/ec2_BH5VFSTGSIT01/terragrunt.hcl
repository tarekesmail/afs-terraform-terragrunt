include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/ec2"
}

terraform {
  source = local.base_source
}

dependency "security_groups" {
  config_path = "../security_groups"
}


inputs = {
  name                   = "BH5VFSTGSIT01"
  instance_type          = "t4g.nano"
  key_name               = "aws_linux_ec2_uat"
  vpc_security_group_ids = [dependency.security_groups.outputs.security_group_id]
  subnet_id              = "subnet-0492121a0bcf153f9"
  ami                    = "ami-07f3b2c233234759f"
  root_block_device = [
    {
      volume_type = "gp3"
      throughput  = 125
      volume_size = 20
    },
  ]
}
