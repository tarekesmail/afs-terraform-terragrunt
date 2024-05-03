include {
  path = find_in_parent_folders()
}

dependency "eks_cloudapi" {
  config_path = "../eks-dmz-cloudapi"
}

terraform {
  source = local.base_source
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/efs"
}


inputs = {
  subnets          = ["subnet-0e5925d4407c1c8dd", "subnet-02b80bbe7fe38086e"]
  creation_token   = "efs-data-tibco-cloudapi-uat"
  performance_mode = "generalPurpose"
  encrypted        = true
  security_groups  = [dependency.eks_cloudapi.outputs.eks.node_security_group_id]
  tags = merge(
    {
      Name = "efs-data-tibco-cloudapi-uat"
    }
  )
}
