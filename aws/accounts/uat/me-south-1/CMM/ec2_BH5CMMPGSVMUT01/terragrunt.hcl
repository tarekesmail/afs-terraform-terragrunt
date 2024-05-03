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
  config_path = "../security_groups/database"
}


inputs = {
  name                   = "BH5CMMPGSVMUT01"
  instance_type          = "t3.large"
  key_name               = "aws_linux_ec2_uat"
  vpc_security_group_ids = [dependency.security_groups.outputs.security_group_id]
  subnet_id              = "subnet-00496331fd2f54f47"
  ami                    = "ami-073b68b942a3f7c44"
  root_block_device = [
    {
      volume_type = "gp3"
      throughput  = 125
      volume_size = 80
    },
  ]
  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 20
      throughput  = 125
    },
    {
      device_name = "/dev/sdg"
      volume_type = "gp3"
      volume_size = 20
      throughput  = 125
    },
    {
      device_name = "/dev/sdh"
      volume_type = "gp3"
      volume_size = 20
      throughput  = 125
    }

  ]  
}
