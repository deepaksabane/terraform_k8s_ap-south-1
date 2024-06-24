

# # EKS Managed Node Group(s)
# #Separate eks_managed_node_group module:


# module "eks_managed_node_group" {
#   source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
#   name = var.cluster_name
#   cluster_version = var.cluster_version
#   subnet_ids = module.vpc.private_subnets
#   cluster_primary_security_group_id = aws_security_group.eks_control_plane_sg.id
#   vpc_security_group_ids            = [module.eks.node_security_group_id ]

#   min_size     = 1
#   max_size     = 10
#   desired_size = 1

#   instance_types = ["t3.large"]
#   capacity_type  = "SPOT"

#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
  
# }
