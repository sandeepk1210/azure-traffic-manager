resource_group_name = "Regroup_2fmmcKxqMNP"

#Network
vnet_name           = "application-vnet"
default_subnet_name = "default"
address_space       = ["10.0.0.0/16"]
default_subnet_cidr = "10.0.0.0/24"

#VM
vm_count       = 4 # Identity how many VMs to be created
admin_username = "adminuser"
vm_size        = "Standard_B2s"

# Load Balancer
lb_count       = 2
lb_name        = "app-lb"
lb_domain_name = "applb-dns-name"
lb_public_ip   = "applb-public-ip"

# Traffic manager
traffic_profile = "appvm-profile"
dns_name        = "weighted-example-sk1210"

