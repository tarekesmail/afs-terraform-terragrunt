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
  cluster_name    = "Tibco-UAT"
  cluster_version = "1.29"
  vpc_id          = "vpc-0390fe94c7c1c98ab"
  subnets         = ["subnet-0c193b69e9ecf1b58", "subnet-0b1cdc7ab467b1fe4"]
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

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
    }
    coredns = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent   = true
      addon_version = "v1.29.1-eksbuild.1"
    }
  }

  eks_managed_node_groups = {
    tibco_uat_ng = {
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
