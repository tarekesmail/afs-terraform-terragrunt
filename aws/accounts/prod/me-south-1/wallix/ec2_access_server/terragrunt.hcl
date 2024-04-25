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

dependency "snet_acm_subnet" {
  config_path = "../../subnets"
}

inputs = {
  name                   = "WALLIX-ACCESS-SERVER"
  instance_type          = "t3.medium"
  key_name               = "Wallix-Access-Manager"
  vpc_security_group_ids = [dependency.security_groups.outputs.security_group_id]
  subnet_id              = dependency.snet_acm_subnet.outputs.subnet_id
  ami                    = "ami-059aa74191b9ad6e1"
  iam_instance_profile   = "SSM"
  private_ip             = "10.72.230.6"
  root_block_device = [
    {
      volume_type = "gp3"
      throughput  = 125
      volume_size = 100
    },
  ]
}
