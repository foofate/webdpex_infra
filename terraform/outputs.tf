output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.kube.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for YSK control plane"
  value       = module.kube.external_cluster_cmd
}