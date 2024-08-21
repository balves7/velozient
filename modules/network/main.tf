resource "azurerm_resource_group" "network" {
  name     = "network"
  location = var.location
}


resource "azurerm_network_security_group" "security-group" {
  name                = "custom-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
}


resource "azurerm_virtual_network" "vnet" {
  name                = "custom-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]


  tags = merge(var.tags, {
    Name       = "custom-vnet"
  })
}

resource "azurerm_subnet" "sn-web" {
    name              = "subnet-web"
    resource_group_name     =  azurerm_resource_group.network.name
    virtual_network_name    = azurerm_virtual_network.vnet.name
    address_prefixes        = ["10.0.0.0/24"]
            
}

resource "azurerm_subnet" "sn-app" {
    name              = "subnet-app"
    resource_group_name     =  azurerm_resource_group.network.name
    virtual_network_name    = azurerm_virtual_network.vnet.name
    address_prefixes        = ["10.0.1.0/24"]
            
}


resource "azurerm_subnet" "sn-db" {
    name              = "subnet-db"
    resource_group_name     =  azurerm_resource_group.network.name
    virtual_network_name    = azurerm_virtual_network.vnet.name
    address_prefixes        = ["10.0.2.0/24"]
            
}

