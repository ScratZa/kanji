variable "location" {
  default = "southafricanorth"
    validation {
    condition     = var.location == "southafricanorth"
    error_message = "The only acceptable value for location is southafricanorth."
  }
}