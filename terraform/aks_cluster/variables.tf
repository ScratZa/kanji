variable "location" {
  default = "southafricanorth"
  validation {
    condition     = var.location == "southafricanorth"
    error_message = "The only acceptable value for location is southafricanorth."
  }
}

variable "namespace" {
  default = "test"
  validation {
    condition     = var.namespace == "test"
    error_message = "The only acceptable value for namespace is test."
  }
}

variable "environment" {
  default = "dev"
  validation {
    condition     = contains(["dev", "sbox"], lower(var.environment))
    error_message = "Environment must exist in either a dev or sandbox namespace."
  }
}

// Resource Groups

variable "aks_resource_group_name" {

}


// Node pool

variable "aks_default_node_pool_count" {
  default = 1
  validation {
    condition     = var.aks_default_node_pool_count <= 3
    error_message = "Node Pool size smaller than 3 supported."
  }
}
variable "aks_default_node_pool_vm_size" {
  default = "Standard_D2_V2"
  validation {
    condition     = contains(["Standard_D2_V2"], var.aks_default_node_pool_vm_size)
    error_message = "Standard_D2_V2 nodes supported."
  }
}

variable "aks_default_node_pool_azs" {
  type    = list(string)
  default = null
}

variable "aks_default_node_pool_node_type" {
  default = "VirtualMachineScaleSets"
  validation {
    condition     = contains(["VirtualMachineScaleSets", "AvailabilitySet"], var.aks_default_node_pool_node_type)
    error_message = "Null VirtualMachineScaleSets or AvailabilitySet is supported."
  }
}
variable "aks_default_node_pool_enable_node_public_ip" {
  default = false
}
variable "aks_default_node_pool_subnet_id"{
  
}
variable "aks_default_node_pool_enable_node_encryption" {
  default = false
}

variable "aks_default_node_pool_max_pods" {
  default = 30
  validation {
    condition     = 10 <= var.aks_default_node_pool_max_pods && var.aks_default_node_pool_max_pods <= 110
    error_message = "Max pods between 10 and 110 supported."
  }
}
variable "aks_default_node_pool_max_node_count"{
default = 3
}
variable "aks_default_node_pool_min_node_count"{
default = 1
}

variable "aks_kubernetes_version" {
  default = "1.19.11"
  validation { 
    condition     = contains(["1.20.0", "1.19.11"], var.aks_kubernetes_version)
    error_message = "Kubernetes versions 1.19 and 1.20 supported."
  }
}

variable"aks_authorized_management_ip_range"{
  default = ["102.65.66.204/32"]
}

variable "ad_admin_group_id" {
  default = null
}

variable "ad_admin_group_name" {
  default = "AKS-Group-Admins"
  description = "Admin group associated with the Kubernetes Control Plane"
}

variable "aks_private_cluster"{
  default = "true"
}
variable "aks_private_dns_zone_id" {
  default = "System"
}
variable "aks_dns_prefix"{
  default = "test"
}