variable "region" {
    description = "The region where the resources are created "
  
}



variable "vpc_name" {
    description = "name of the vpc"
  
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
}

variable "cluster_version" {
    description = "The kubernetes cluster version"
    type = string 
}

