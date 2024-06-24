variable "region" {
    description = "The region where the resources are created "
  
}

variable "create" {
  description = "Flag to determine if resources should be created"
  type        = bool
  default     = true  # Set to true if you're creating/updating resources
}


variable "vpc_name" {
    description = "name of the vpc"
  
}

variable "cluster_service_cidr" {
  description = "The CIDR block for the Kubernetes service network."
  type        = string
  default     = "10.100.0.0/16"
}


variable "main_cidr" {
  description = "cidr value of vpc "

}

variable "azs" {
    description = "availability zones"
    type = list(string)
}

variable "private_subnets" {
    description = "private subnets "
    type = list(string)
  
}

variable "public_subnets" {
    description = "public subnets"
    type = list(string)
  
}

variable "cluster_name" {
    description = "The kubernetes cluster name"
    type = string
    default = "arati-eks"
}

variable "cluster_version" {
    description = "The kubernetes cluster version"
    type = string 
}

# variable "map_public_ip_on_launch" {
#   description = "Flag to map public IP on launch for instances in public subnets."
#   type        = bool
# }
