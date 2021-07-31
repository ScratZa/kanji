provider "azurerm" {
  features {}
}

module "test" {
    source = "../../"

    location = "southafricanorth"
    namespace = "test"
    environment = "dev"
}