resource_group_name = "Regroup_8akor5"

#Network
vnet_name           = "application-vnet"
default_subnet_name = "default"
address_space       = ["10.0.0.0/16"]
default_subnet_cidr = "10.0.0.0/24"

#VM
vm_count       = 2 # Identity how many VMs to be created
admin_username = "adminuser"
vm_size        = "Standard_B2s"

# Load Balancer
lb_name        = "lb-pimary"
lb_domain_name = "lb-primary-dns-name"
lb_public_ip   = "lb-primary-public-ip"

# Traffic manager
traffic_profile = "vm-profile"
dns_name        = "weighted-example-sk1210"

