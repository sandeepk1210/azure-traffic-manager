# Random string for unique Key Vault name
resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                       = "appkv-${lower(random_string.unique.result)}"
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Get", "Set", "Delete", "List"]
  }
}

# Random password
resource "random_password" "admin_password" {
  count            = var.vm_count
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

# Store Admin Password in Key Vault
resource "azurerm_key_vault_secret" "admin_password" {
  count        = var.vm_count
  name         = "vm-admin-password-${count.index + 1}"
  value        = random_password.admin_password[count.index].result
  key_vault_id = azurerm_key_vault.kv.id
}
