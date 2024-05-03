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
  config_path = "../../security_groups"
}

dependency "snet_pam" {
  config_path = "../../subnets"
}

inputs = {
  name                   = "WALLIX-RDS"
  instance_type          = "t3.medium"
  key_name               = "Wallix-RDS"
  vpc_security_group_ids = [dependency.security_groups.outputs.security_group_id]
  subnet_id              = dependency.snet_pam.outputs.subnet_id
  ami                    = "ami-04c52cddf224e1091"
  private_ip             = "10.70.76.7"
  root_block_device = [
    {
      volume_type = "gp3"
      throughput  = 125
      volume_size = 100
    },
  ]
  tags = {
    BACKUP_ENABLED = "true"
  }
}
