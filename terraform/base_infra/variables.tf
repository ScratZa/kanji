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

//// NETWORK CON

variable "vpc_provided_name" {
  default = null
}

variable "vpc_provided_resource_group_name" {
  default = null
}

variable "vpc_address_space" {
  default = "12.0.0.0/21"
}

variable "vpc_subnet_prefixes" {
  default = ["12.0.0.0/23"]
}
//// Resource Groups 

variable "provided_resource_group_name" {
  default = null
}