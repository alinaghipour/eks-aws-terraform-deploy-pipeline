output "config_map_aws_auth" {
  description = "Done -- kubernetes configuration to auth to EKS cluster."
  value       = module.eks.config_map_aws_auth
}

output "kubectl_config" {
  description = "Done -- kubectl config as generated"
  value       = module.eks.kubeconfig
}

output "cluster_security_group_id" {
  description = "Done -- Security group ids attached - endpoint"
  value       = module.eks.cluster_security_group_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "region" {
  description = "Output region - AWS region"
  value       = var.region
}