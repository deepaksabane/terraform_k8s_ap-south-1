module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.14.0"

  cluster_name                     = var.cluster_name
  cluster_version                  = var.cluster_version
  cluster_endpoint_public_access   = true
  cluster_endpoint_private_access  = true
  vpc_id                           = module.vpc.vpc_id
  subnet_ids                       = module.vpc.private_subnets
  control_plane_subnet_ids         = module.vpc.public_subnets
  cluster_enabled_log_types        = []
  create_cloudwatch_log_group      = true
  enable_irsa                      = true

  cluster_addons = {
    coredns = {
        most_recent = true
    }
    kube-proxy = {
        most_recent = true
    }
    vpc-cni = {
        most_recent = true
    }
  }

  tags = {
    Name = "dev"
  }

  # EKS Managed Node Group Defaults
  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.eks_control_plane_sg.id]
  }

  # EKS Managed Node Groups
  eks_managed_node_groups = {
    node_group = {
      min_size     = 2
      max_size     = 6
      desired_size = 2
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:sso:::permissionSet/ssoins-659506d4257a1c38/ps-619b8b29fea89ea3" # Replace with your IAM Role ARN

      policy_associations = {
        example = {
          policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
          access_scope = {
            namespaces = ["*"] # Grant access to all namespaces
            type       = "cluster" # Grant access to the whole cluster
          }
        }
      }
    }
  }
}
