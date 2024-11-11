# Azure Virtual Machine with Traffic Manager and Load Balancer

This Terraform configuration creates an Azure environment with Virtual Machines (VMs), a Traffic Manager profile, and a Load Balancer. The Traffic Manager profile uses the Weighted routing method to distribute traffic between multiple endpoints.

## Prerequisites

- Terraform installed (version 0.12+)
- Azure CLI installed and authenticated
- An Azure subscription with sufficient privileges to create resources

## Configuration Overview

The configuration provisions the following resources:

- **Azure Resource Group**
- **Virtual Network** and **Subnet**
- **Windows Virtual Machines** (VMs)
- **Azure Traffic Manager Profile** with **Weighted Routing**
- **Load Balancer** with health probes and backend pool
- **Key Vault** to store admin passwords
- **Public IP** for Load Balancer
- **Network Security Group (NSG)** with security rules for HTTP and RDP

## Variables

You can modify the following variables in `variables.tf` to customize the environment:

- `resource_group_name` (string): Name of the resource group.
- `vnet_name` (string): Name of the virtual network.
- `default_subnet_name` (string): Name of the default subnet.
- `address_space` (list): Address space for the virtual network.
- `default_subnet_cidr` (string): CIDR block for the default subnet.
- `vm_count` (number): Number of VMs to create.
- `vm_size` (string): Size of the virtual machines.
- `admin_username` (string): Admin username for the virtual machines.

## Usage

1. Clone this repository.
2. Update the variables as per your environment.
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Plan the execution to review the changes:
   ```bash
   terraform plan
   ```
5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Terraform Resources

### Traffic Manager Profile

- A Traffic Manager profile (`azurerm_traffic_manager_profile`) is created to distribute traffic using the **Weighted** routing method between VM endpoints.

### Traffic Manager Endpoint

- Each VM is assigned as an endpoint to the Traffic Manager with a specified weight.

### Virtual Network and Subnet

- A Virtual Network (`azurerm_virtual_network`) and a Subnet (`azurerm_subnet`) are created for networking the VMs.

### Virtual Machines

- The VMs (`azurerm_windows_virtual_machine`) are created using the `WindowsServer` 2019 Datacenter image.
- Network interfaces (`azurerm_network_interface`) are attached to the VMs.
- Network Security Group (`azurerm_network_security_group`) with rules for HTTP and RDP access.

### Load Balancer

- A Load Balancer (`azurerm_lb`) is created with a frontend IP and backend pool.
- A Health Probe (`azurerm_lb_probe`) is configured for the backend pool.

### Key Vault

- A Key Vault (`azurerm_key_vault`) is used to securely store the admin password for the VMs.

## Outputs

You can view the public IP of the load balancer after running `terraform apply`:

```bash
terraform output app_lb_public_ip
```
