resource "azurerm_network_interface" "app-vm-nic" {
  count               = var.app_server_count
  name                = "app-vm-nic${count.index}"
  location            = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.appzone-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_availability_set" "app-vm-avset" {
  name                         = "app-vm-avset"
  location                     = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name          = azurerm_resource_group.fr-central-rs-group.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

resource "azurerm_linux_virtual_machine" "app-vm" {
  count               = var.app_server_count
  name                = "app-vm${count.index}"
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name
  location            = azurerm_resource_group.fr-central-rs-group.location
  size                = "Standard_B1ms"
  admin_username      = "adminuser"
  availability_set_id = azurerm_availability_set.app-vm-avset.id
  network_interface_ids = [
    element(azurerm_network_interface.app-vm-nic.*.id, count.index),
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-12"
    sku       = "12"
    version   = "latest"
  }
}

resource "azurerm_network_interface_security_group_association" "app-sg-assoc" {
  count                     = var.app_server_count
  network_interface_id      = element(azurerm_network_interface.app-vm-nic.*.id, count.index)
  network_security_group_id = azurerm_network_security_group.app-sg.id
}
