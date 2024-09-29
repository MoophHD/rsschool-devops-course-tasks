variable "region" {
  type    = string
  default = "us-east-1"
}

variable "github_org" {
  type    = string
  default = "MoophHD"
}

variable "role_name" {
  type    = string
  default = "GithubActionsRole-DSS"
}

variable "bucket_name" {
  type    = string
  default = "terraform-state-bucket-dss"
}

