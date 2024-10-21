output "vpc_id" {
  value = module.vpc.vpc_id
}

output "k3s_private_ip" {
  value = module.k3s.private_ip
}

output "lb_dns_name" {
  value = module.loadbalancer.lb_dns_name
}

output "kubeconfig_path" {
  value = "/etc/rancher/k3s/k3s.yaml"
}