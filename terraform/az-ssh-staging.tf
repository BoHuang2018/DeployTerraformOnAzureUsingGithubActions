resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource" "ssh_public_key_staging" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = random_pet.ssh_key_name.id
  location  = var.location
  parent_id = azurerm_resource_group.coop-interview-staging.id
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key_staging.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey"]
}

output "key_data" {
  value     = azapi_resource.ssh_public_key_staging.body
  sensitive = true
}