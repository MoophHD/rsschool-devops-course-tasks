variable "bastion_ip" {
  type = string
}

variable "bastion_keypair_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

