resource "azurerm_public_ip" "nat-gw-public-ip" {
  name = "nat-gw-public-ip"
  location = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_nat_gateway" "nat-gw" {
  name = "nat-gw"
  location = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name
  sku_name = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat-gw-public-ip-assoc" {
  nat_gateway_id = azurerm_nat_gateway.nat-gw.id
  public_ip_address_id = azurerm_public_ip.nat-gw-public-ip.id
}

resource "azurerm_subnet_nat_gateway_association" "appzone-subnet-nat-gw-assoc" {
  subnet_id = azurerm_subnet.appzone-subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat-gw.id
}
