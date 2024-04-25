include {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/eks"
}

terraform {
  source = local.base_source
}

inputs = {
  cluster_name    = "Tibco-CloudAPI-UAT"
  cluster_version = "1.29"
  vpc_id          = "vpc-0f20c8a4e0e438497"
  subnets         = ["subnet-0e5925d4407c1c8dd", "subnet-02b80bbe7fe38086e"]
  access_entries = {
    jump_box_access = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::533119714054:role/Tibco-Vendor-JS"
      policy_associations = {
        single = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
  eks_managed_node_groups = {
    tibco_cloudapi_uat_ng = {
      min_size     = 1
      max_size     = 10
      desired_size = 1
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"

    }
  }
}
