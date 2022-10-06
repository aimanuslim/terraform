
/*{
  "appId": "bcd0ac8c-c29b-44ee-9107-317260fdb991",
  "displayName": "azure-cli-2022-10-03-02-35-40",
  "password": "aU18Q~4pTvDDcjmRAL1oVzdSVHQRr.U0tGtnUbuU",
  "tenant": "6ca458d8-2f10-4cd2-a2d7-c5db3e6eacf7"
}*/

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
  subscription_id = "5e0b5cdf-a97f-4e0d-b8b6-5ca78f448046"
  client_id       = "bcd0ac8c-c29b-44ee-9107-317260fdb991"
  client_secret   = "aU18Q~4pTvDDcjmRAL1oVzdSVHQRr.U0tGtnUbuU"
  tenant_id       = "6ca458d8-2f10-4cd2-a2d7-c5db3e6eacf7"
}

resource "azurerm_resource_group" "example" {
  provider = azurerm.dev
  name     = var.rgname
  location = var.rglocation
}


  



