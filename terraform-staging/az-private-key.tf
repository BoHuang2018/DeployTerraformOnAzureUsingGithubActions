resource "tls_private_key" "key_staging" {
  algorithm = "RSA"
}

output "cluster_private_key" {
  value     = tls_private_key.key_staging.private_key_pem
  sensitive = true
}

output "cluster_public_key" {
  value = tls_private_key.key_staging.public_key_pem
}