variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "vpd_cidr_block" {
  description = "The Main Cidr Block of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets"
  type        = list(string)
}

variable "bastion_sg_id" {
  description = "ID of the bastion security group"
  type        = string
}

variable "k3s_token" {
  description = "Token for K3s cluster"
  type        = string
}

variable "bastion_keypair_name" {
  description = "Name of the keypair used for bastion host"
  type        = string
}
