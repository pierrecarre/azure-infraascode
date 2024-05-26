resource "azurerm_virtual_network_peering" "rb-to-main-peering" {
  name                      = "rb-to-main"
  resource_group_name       = data.azurerm_resource_group.rebound-res-group.name
  virtual_network_name      = data.azurerm_virtual_network.rebound-network.name
  remote_virtual_network_id = azurerm_virtual_network.main-network.id
}

resource "azurerm_virtual_network_peering" "main-to-rb-peering" {
  name                      = "main-to-rb"
  resource_group_name       = azurerm_resource_group.fr-central-rs-group.name
  virtual_network_name      = azurerm_virtual_network.main-network.name
  remote_virtual_network_id = data.azurerm_virtual_network.rebound-network.id
}