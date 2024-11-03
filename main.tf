terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-bucket-dss"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

module "github_actions" {
  source = "./modules/github_actions"

  github_org  = var.github_org
  github_repo = var.github_repo
  role_name   = var.github_role_name
}

module "networking" {
  source = "./modules/networking"
}

module "bastion" {
  source               = "./modules/bastion"
  bastion_ip           = var.bastion_ip
  bastion_keypair_name = var.bastion_keypair_name
  vpc_id               = module.networking.vpc_id
  public_subnet_ids    = module.networking.public_subnet_ids

  depends_on = [module.networking]
}

module "k3s" {
  source             = "./modules/k3s"
  vpc_id             = module.networking.vpc_id
  vpd_cidr_block     = module.networking.vpc_cidr_block
  private_subnet_ids = module.networking.private_subnet_ids

  bastion_sg_id        = module.bastion.bastion_sg_id
  k3s_token            = var.k3s_token
  bastion_keypair_name = var.bastion_keypair_name

  depends_on = [module.networking, module.bastion]
}

