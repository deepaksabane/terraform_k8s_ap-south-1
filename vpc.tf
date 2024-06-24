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

# module "public_subnets" {
#   source  = "claranet/vpc-modules/aws//modules/public-subnets"
#   version = "0.4.0"

#   vpc_id                  = module.vpc.vpc_id
#   gateway_id              = module.vpc.internet_gateway_id
#   map_public_ip_on_launch = true
#   cidr_block              = var.public_subnets[0] // Use the first subnet CIDR as an example
#   subnet_count            = length(var.public_subnets)
#   availability_zones      = var.azs
# }
