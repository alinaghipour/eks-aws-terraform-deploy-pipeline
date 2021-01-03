variable "region" {
  default     = "us-east-1"
  description = "AWS region variable"
}

variable "cluster_name" {
  default = "eks-asw-terraform-deploy"
}

variable "map_accounts" {
  description = "Add AWS accoun to the aws-auth configmap."
  type        = list(string)

  default = [
    "map-account-default-2",
    "map-account-default-3",
  ]
}

variable "map_roles" {
  description = "Add IAM roles to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::user-account-default-map:role/role-default-fisrt"
      username = "role-default-fisrt"
      groups   = ["system:masters"]
    },
  ]
}

variable "map_users" {
  description = "Add IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::user-account-default-map:user/user-default-first"
      username = "user-default-first"
      groups   = ["system:masters"]
    },
  ]
}
