resource "azurerm_traffic_manager_profile" "vm_profile" {
  name                   = var.traffic_profile
  resource_group_name    = data.azurerm_resource_group.rg.name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = var.dns_name
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = "NONPROD"
  }
}

# Traffic Manager Endpoints for each Load Balancer
resource "azurerm_traffic_manager_azure_endpoint" "vm_endpoint" {
  count                = var.lb_count
  name                 = "appvm-endpoint-${count.index + 1}"
  profile_id           = azurerm_traffic_manager_profile.vm_profile.id
  always_serve_enabled = true
  weight               = count.index + 1
  target_resource_id   = azurerm_public_ip.app_lb_public_ip[count.index].id
}
