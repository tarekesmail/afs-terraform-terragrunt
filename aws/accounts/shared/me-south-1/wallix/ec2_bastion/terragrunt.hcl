include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/ec2"
}

terraform {
  source = local.base_source
}

dependency "snet_pam" {
  config_path = "../../subnets"
}

inputs = {
  name                   = "WALLIX-BASTION"
  instance_type          = "t3.xlarge"
  key_name               = "WALLIX-BASTION"
  vpc_security_group_ids = ["sg-04077542563cfabeb", "sg-087322d2429449ae0"]
  subnet_id              = dependency.snet_pam.outputs.subnet_id
  ami                    = "ami-035b125c384e0c737"
  private_ip             = "10.70.76.6"
  root_block_device = [
    {
      volume_type = "gp3"
      throughput  = 125
      volume_size = 500
    },
  ]
}
