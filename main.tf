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

resource "azurerm_virtual_network" "example" {
  provider            = azurerm.dev
  name                = "test-vnet"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.example.name #cross referencing argument/attribute
  location            = azurerm_resource_group.example.location
}
resource "azurerm_subnet" "example" {
  provider             = azurerm.dev
  name                 = "test-subnet"
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
}
resource "azurerm_public_ip" "example" {
  provider            = azurerm.dev
  name                = "test-publicip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "example" {
  provider            = azurerm.dev
  name                = "test-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
    primary                       = true
  }
}
resource "azurerm_windows_virtual_machine" "example" {
  provider            = azurerm.dev
  name                = "test-windowsvm"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

  



