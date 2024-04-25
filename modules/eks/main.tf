module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.8.1"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups                  = var.eks_managed_node_groups
  cluster_encryption_config                = var.cluster_encryption_config

  create_iam_role          = true
  iam_role_name            = "eks-${var.cluster_name}-node-group-role"
  iam_role_use_name_prefix = false
  iam_role_description     = "EKS managed node group role"
  access_entries           = var.access_entries
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
      most_recent = true
    }

  }

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  tags                      = var.tags
}

resource "aws_iam_role" "this" {

  name = "${var.cluster_name}-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "Example"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}