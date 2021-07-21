terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

module "kanji-aks-rg-label" {
  source = "cloudposse/label/terraform"

  namespace  = "kanji"
  stage      = "dev"
  name       = "aks"
  attributes = ["rg"]
  delimiter  = "-"

  tags = {
    "Application" = "Kanji",
    "TearDown"     = "true"
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
  name = module.kanji-aks-rg-label.id
  location = var.location
}