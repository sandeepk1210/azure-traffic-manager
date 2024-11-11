# Outputs for the Traffic Manager Profile
output "traffic_manager_profile_id" {
  description = "The ID of the Traffic Manager profile"
  value       = azurerm_traffic_manager_profile.vm_profile.id
}

output "traffic_manager_dns_name" {
  description = "The DNS name of the Traffic Manager profile"
  value       = azurerm_traffic_manager_profile.vm_profile.dns_config[0].relative_name
}

output "traffic_manager_endpoints" {
  description = "The IDs and weights of each Traffic Manager endpoint"
  value = [
    for endpoint in azurerm_traffic_manager_azure_endpoint.vm_endpoint :
    {
      id     = endpoint.id,
      name   = endpoint.name,
      weight = endpoint.weight
    }
  ]
}

# Outputs for Load Balancers
output "load_balancer_public_ips" {
  description = "The public IPs of the load balancers"
  value = [
    for lb_ip in azurerm_public_ip.app_lb_public_ip :
    {
      id                = lb_ip.id,
      name              = lb_ip.name,
      ip_address        = lb_ip.ip_address,
      domain_name_label = lb_ip.domain_name_label
    }
  ]
}

output "load_balancer_ids" {
  description = "The IDs of the load balancers"
  value       = [for lb in azurerm_lb.app_lb : lb.id]
}

output "load_balancer_backend_pools" {
  description = "The backend pool IDs for each load balancer"
  value = [
    for pool in azurerm_lb_backend_address_pool.app_backend_pool :
    {
      id   = pool.id,
      name = pool.name
    }
  ]
}
