variable "app_name" {
  default = "simpleApp"
}

variable "location" {
  default = "Norway East"
}

variable "container_registry_name_prod" {
  default = "simpleAppImages"
}

variable "container_registry_name_staging" {
  default = "simpleAppImagesStagingTest"
}

variable "admin_username" {
  default = "simpleApp_admin"
}

variable "node_count" {
  type        = number
  description = "The number of nodes for a node pool in AKS."
  default     = 2
}
