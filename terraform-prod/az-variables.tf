variable "app_name" {
  default = "simpleAppProd"
}

variable "location" {
  default = "Norway East"
}

variable "container_registry_name_prod" {
  default = "simpleAppImagesProd"
}

variable "admin_username" {
  default = "simpleApp_admin"
}

variable "node_count" {
  type        = number
  description = "The number of nodes for a node pool in AKS."
  default     = 2
}
