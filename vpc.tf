#https://shivansh438.awsapps.com/start

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = var.vpc_name
  cidr = var.main_cidr

  azs                  = var.azs
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true


 tags = {
    "kubernetes.io/cluster/arati-eks" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/arati-eks" = "shared"
    "kubernetes.io/role/elb"          = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/arati-eks" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
