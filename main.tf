terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}

  alias           = "dev"
}

resource "azurerm_resource_group" "example" {
  provider = azurerm.dev
  name     = var.rgname
  location = var.rglocation
}


  



