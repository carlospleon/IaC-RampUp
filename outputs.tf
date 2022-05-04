output "lb_endpoint" {
  value = "http://${module.loadbalancer.lb_endpoint}"
}

output "db_endpoint" {
  description = "RDS Endpoint"
  value       = module.database.endpoint
}

output "JenkinsBastion_IP" {
  description = "Jenkins ip address"
  value       = module.JenkinsBastion.instance_public_ip
}

output "K8s_master_IP"{
  description = "Master node ip address"
  value       = module.k8s_master.instance_private_ip
}

output "K8s_worker_IP"{
  description = "Worker node ip address"
  value       = module.k8s_worker.instance_private_ip
}

output "K8s_worker2_IP"{
  description = "Worker node ip address"
  value       = module.k8s_worker2.instance_private_ip
}