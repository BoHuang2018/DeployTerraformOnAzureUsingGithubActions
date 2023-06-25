resource "azurerm_container_registry" "container_registry_staging" {
  location            = var.location
  name                = var.container_registry_name_staging
  resource_group_name = azurerm_resource_group.coop-interview-staging.name
  admin_enabled       = true
  sku                 = "Basic"
}

output "registry_hostname_staging" {
  value = azurerm_container_registry.container_registry_staging.login_server
}

output "registry_un_staging" {
  value = azurerm_container_registry.container_registry_staging.admin_username
}

output "registry_pw_staging" {
  value     = azurerm_container_registry.container_registry_staging.admin_password
  sensitive = true
}