variable "region" {
  default     = "us-east-1"
  description = "AWS region variable"
}


variable "env" {
  description = "Depolyment environment"
  default     = "dev"
}
variable "repository_owner" {
  description = "repository owner"
  default     = "alinaghipour"
}

variable "repository_branch" {
  description = "Repository branch"
  default     = "master"
}
variable "static_web_bucket_name" {
  description = "S3 Bucket to deploy to"
  default     = "web-nginx-terraform-bucket"
}

variable "artifacts_bucket_name" {
  description = "S3 Bucket for storing artifacts"
  default     = "web-nginx-terraform-artifacts-bucket"
}
variable "repository_name" {
  description = "repository name"
  default     = "web-nginx-terraform"
}