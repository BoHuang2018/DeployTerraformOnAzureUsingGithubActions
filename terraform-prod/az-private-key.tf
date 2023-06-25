resource "tls_private_key" "key_prod" {
  algorithm = "RSA"
}

output "cluster_private_key" {
  value     = tls_private_key.key_prod.private_key_pem
  sensitive = true
}

output "cluster_public_key" {
  value = tls_private_key.key_prod.public_key_pem
}