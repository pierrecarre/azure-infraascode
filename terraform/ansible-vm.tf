resource "azurerm_network_interface" "ansible-vm-nic" {
  name                = "ansible-vm-nic"
  location            = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.toolzone-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "ansible-vm" {
  name                = "ansible-vm"
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name
  location            = azurerm_resource_group.fr-central-rs-group.location
  size                = "Standard_B1ms"
  admin_username      = "ansible"
  network_interface_ids = [
    azurerm_network_interface.ansible-vm-nic.id,
  ]

  admin_ssh_key {
    username   = "ansible"
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

resource "azurerm_network_interface_security_group_association" "ansible-vm-admin-sg-assoc" {
  network_interface_id      = azurerm_network_interface.ansible-vm-nic.id
  network_security_group_id = azurerm_network_security_group.admin-sg.id
}