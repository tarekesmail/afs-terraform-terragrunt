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
  cluster_name    = "TF-SoftPOS-Prod"
  cluster_version = "1.29"
  vpc_id          = "vpc-0d4e2de3d4ab22aba"
  subnets         = ["subnet-00992dac18828900c", "subnet-0a78dbdc847fff53c", "subnet-026b4abce884bf9e5"]
  access_entries = {
    jump_box_access = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::370525687312:role/MS-Engineer"
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
    softpos_ng = {
      min_size     = 2
      max_size     = 10
      desired_size = 2
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
      instance_types = ["t3.large"]
      capacity_type  = "ON_DEMAND"

    }
  }
}
