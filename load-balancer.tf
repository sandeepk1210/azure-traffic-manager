# Public IP for Load Balancers
resource "azurerm_public_ip" "app_lb_public_ip" {
  count               = var.lb_count
  name                = "${var.lb_name}-${count.index + 1}-public-ip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${var.lb_domain_name}-${count.index + 1}"
}

# Load Balancers
resource "azurerm_lb" "app_lb" {
  count               = var.lb_count
  name                = "${var.lb_name}-${count.index + 1}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "appFrontEnd"
    public_ip_address_id = azurerm_public_ip.app_lb_public_ip[count.index].id
  }
}

# Load Balancer Backend Address Pools
resource "azurerm_lb_backend_address_pool" "app_backend_pool" {
  count           = var.lb_count
  name            = "appBackendPool-${count.index + 1}"
  loadbalancer_id = azurerm_lb.app_lb[count.index].id
}

# Associate NICs with Load Balancer Backend Pools
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association" {
  count                 = var.vm_count
  ip_configuration_name = "internal"
  # Distribution across multiple boad balancers
  network_interface_id    = azurerm_network_interface.nic[count.index % var.lb_count].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.app_backend_pool[count.index % var.lb_count].id
}

# Load Balancer Health Probes
resource "azurerm_lb_probe" "app_health_probe" {
  count               = var.lb_count
  name                = "appHealthProbe-${count.index + 1}"
  loadbalancer_id     = azurerm_lb.app_lb[count.index].id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

# Load Balancer Rules
resource "azurerm_lb_rule" "app_lb_rule" {
  count                          = var.lb_count
  name                           = "appLoadBalancingRule-${count.index + 1}"
  loadbalancer_id                = azurerm_lb.app_lb[count.index].id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "appFrontEnd"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.app_backend_pool[count.index].id]
  probe_id                       = azurerm_lb_probe.app_health_probe[count.index].id
}
