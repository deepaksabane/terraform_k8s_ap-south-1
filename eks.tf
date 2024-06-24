module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

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
  depends_on = [
    aws_iam_role.eks-iam-role,
  ]

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    "kube-proxy" = {
      most_recent = true
    }
    "vpc-cni" = {
      most_recent = true
    }
  }

  tags = {
    Name = "dev"
  }

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    node_role_arn          = aws_iam_role.workernodes.arn
    vpc_security_group_ids = [aws_security_group.eks_control_plane_sg.id]  # Ensure this SG is defined
  }

  
  eks_managed_node_groups = {
    node_group = {
      min_size     = 2
      max_size     = 6
      desired_size = 2
      tags = {
        Name = "dev"
      }
      depends_on = [
        aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
        module.vpc_id
        #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
      ]
    }
  }

  access_entries = {
    example = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::905418412366:sso-instance/AWSReservedSSO_shivanshset_804d182bd08ab8d1/sso-user/arati/f1939daa-80e1-7093-a34f-7b0334e29b02"
      policy_associations = {
        example = {
          policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
          access_scope = {
            namespaces = ["*"]
            type       = "cluster"
          }
        }
      }
    }
  }
}
