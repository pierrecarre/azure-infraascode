resource "azurerm_network_security_group" "admin-sg" {
  name                = "admin-sg"
  location            = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name
}

resource "azurerm_network_security_rule" "ssh-rule" {
  name                        = "allow-ssh-from-rebound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.fr-central-rs-group.name
  network_security_group_name = azurerm_network_security_group.admin-sg.name
}

resource "azurerm_network_security_group" "app-sg" {
  name                = "app-sg"
  location            = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name
}

resource "azurerm_network_security_rule" "allow-ssh-from-rebound" {
  name                        = "allow-ssh-from-rebound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.fr-central-rs-group.name
  network_security_group_name = azurerm_network_security_group.app-sg.name
}

resource "azurerm_network_security_rule" "allow-ssh-from-toolzone" {
  name                        = "allow-ssh-from-toolzone"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "192.168.1.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.fr-central-rs-group.name
  network_security_group_name = azurerm_network_security_group.app-sg.name
}