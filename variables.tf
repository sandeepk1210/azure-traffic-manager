variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

# Network
variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "default_subnet_name" {
  type        = string
  description = "Name of the default subnet"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "default_subnet_cidr" {
  type        = string
  description = "CIDR block for the default subnet"
}

# VM
variable "vm_count" {
  type        = number
  description = "The number of virtual machines to create"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machines"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machines"
}

# Load Balancer
# Variable for the count of Load Balancers
variable "lb_count" {
  type        = number
  description = "The number of load balancers to create"
}

variable "lb_domain_name" {
  type = string
}

variable "lb_public_ip" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "traffic_profile" {
  type = string

}
