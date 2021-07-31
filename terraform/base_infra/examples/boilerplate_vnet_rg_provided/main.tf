provider "azurerm" {
  features {}
}

module "test" {
    source = "../../"

    location = "southafricanorth"
    namespace = "test"
    environment = "dev"
    provided_vpc_name = "test-dev-aks-vnet"
    provided_vpc_resource_group_name = "test-dev-aks-rg"

    provided_resource_group_name = "moja-dev-aks-rg"
}