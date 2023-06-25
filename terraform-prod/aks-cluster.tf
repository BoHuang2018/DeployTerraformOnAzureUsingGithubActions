resource "azurerm_kubernetes_cluster" "k8s_staging" {
  location            = var.location
  name                = var.app_name
  resource_group_name = azurerm_resource_group.coop-interview-prod.name
  dns_prefix          = var.app_name
  kubernetes_version  = "1.25"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_B2ms"
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}