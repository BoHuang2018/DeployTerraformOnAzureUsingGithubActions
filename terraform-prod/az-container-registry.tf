resource "azurerm_container_registry" "container_registry_prod" {
  location            = var.location
  name                = var.container_registry_name_prod
  resource_group_name = azurerm_resource_group.coop-interview-prod.name
  admin_enabled       = true
  sku                 = "Basic"
}

output "registry_hostname_staging" {
  value = azurerm_container_registry.container_registry_prod.login_server
}

output "registry_un_staging" {
  value = azurerm_container_registry.container_registry_prod.admin_username
}

output "registry_pw_staging" {
  value     = azurerm_container_registry.container_registry_prod.admin_password
  sensitive = true
}