# Output for Load Balancer Public IP
output "app_lb_public_ip" {
  value = azurerm_public_ip.app_lb_public_ip.ip_address
  description = "The public IP address of the Load Balancer"
}

# Output for Traffic Manager Profile DNS Name
output "traffic_manager_profile_dns" {
  value = azurerm_traffic_manager_profile.vm_profile.dns_config[0].relative_name
  description = "The DNS name of the Traffic Manager Profile"
}

# Output for VM IP addresses
output "vm_private_ips" {
  value = [for nic in azurerm_network_interface.nic : nic.ip_configuration[0].private_ip_address]
  description = "The private IP addresses of the virtual machines"
}

# Output for VM Names
output "vm_names" {
  value = [for vm in azurerm_windows_virtual_machine.vm : vm.name]
  description = "The names of the created virtual machines"
}

# Output for Key Vault Secret ID (Admin password)
output "key_vault_secret_id" {
  value = azurerm_key_vault_secret.admin_password.id
  description = "The ID of the Key Vault secret for the admin password"
}

# Output for Virtual Network and Subnet Details
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
  description = "The name of the virtual network"
}

output "subnet_name" {
  value = azurerm_subnet.default_subnet.name
  description = "The name of the default subnet"
}

# Output for Network Security Group
output "network_security_group_id" {
  value = azurerm_network_security_group.nsg.id
  description = "The ID of the created Network Security Group"
}

# Output for the DNS label of the Load Balancer Public IP
output "app_lb_dns_name" {
  value = azurerm_public_ip.app_lb_public_ip.domain_name_label
  description = "The DNS label associated with the Load Balancer public IP"
}
