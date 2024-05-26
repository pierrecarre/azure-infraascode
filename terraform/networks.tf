resource "azurerm_virtual_network" "main-network" {
  name                = "main-network"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name
}

resource "azurerm_subnet" "toolzone-subnet" {
  name                 = "toolzone"
  resource_group_name  = azurerm_resource_group.fr-central-rs-group.name
  virtual_network_name = azurerm_virtual_network.main-network.name
  address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "appzone-subnet" {
  name                 = "appzone"
  resource_group_name  = azurerm_resource_group.fr-central-rs-group.name
  virtual_network_name = azurerm_virtual_network.main-network.name
  address_prefixes     = ["192.168.5.0/24"]
}