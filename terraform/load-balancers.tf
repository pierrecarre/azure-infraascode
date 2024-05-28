resource "azurerm_lb" "app-service-lb" {
  name                = "app-service"
  location            = azurerm_resource_group.fr-central-rs-group.location
  resource_group_name = azurerm_resource_group.fr-central-rs-group.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "private"
    subnet_id                     = azurerm_subnet.appzone-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_rule" "app-service-lb-rule" {
  loadbalancer_id                = azurerm_lb.app-service-lb.id
  name                           = "80-lbrule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.app-service-lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.app-service-lb-addr-pool.id]
}

resource "azurerm_lb_backend_address_pool" "app-service-lb-addr-pool" {
  loadbalancer_id = azurerm_lb.app-service-lb.id
  name            = "AppServiceBackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "app-nic-app-service-lb-addr-pool-assoc" {
  count                   = var.app_server_count
  network_interface_id    = element(azurerm_network_interface.app-vm-nic.*.id, count.index)
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.app-service-lb-addr-pool.id
}