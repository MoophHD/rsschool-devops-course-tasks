variable "region" {
  type    = string
  default = "us-east-1"
}

variable "github_org" {
  type    = string
  default = "MoophHD"
}

variable "github_repo" {
  type    = string
  default = "rsschool-devops-course-tasks"
}

variable "role_name" {
  type    = string
  default = "GithubActionsRole-DSS"
}

variable "bucket_name" {
  type    = string
  default = "terraform-state-bucket-dss"
}

variable "bastion_ip" {
  type = string
  # default = null // Replace with an actual IP address like 192.168.1.100/32
  default = "0.0.0.0/0" // allow from everywhere; security risk
}

variable "bastion_keypair_name" {
  type = string
  # default = "bastion-keypair"
  default = "bruhkeyname"
}

variable "k3s_token" {
  type    = string
  default = "k3s_token"
}


