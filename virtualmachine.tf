
resource "azurerm_virtual_network" "main" {
  for_each            = local.virtual_machines_map
  name                = each.value.name
  address_space       = var.resource_group_name_network_address
  location            = each.value.location
  resource_group_name = var.resource_group_name_network_name
}


resource "azurerm_subnet" "internal" {
  for_each             = local.virtual_machines_map
  name                 = var.azurerm_subnet_name
  resource_group_name  = var.azurerm_subnet_name_resource_group_name
  virtual_network_name = var.azurerm_subnet_virtual_network_name
  address_prefixes     = var.azurerm_subnet_address_prefixes
}


resource "azurerm_network_interface" "main" {
  for_each            = local.virtual_machines_map
  name                = each.value.name
  location            = var.azurerm_network_interface_location
  resource_group_name = var.azurerm_network_interface_resource_group_name

  ip_configuration {
    name                          = var.azurerm_network_interface_ip_configuration_name
    subnet_id                     = azurerm_subnet.internal[each.key].id
    private_ip_address_allocation = var.azurerm_network_interface_rivate_ip_address_allocation
  }
}


resource "azurerm_virtual_machine" "main" {
  for_each              = local.virtual_machines_map
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = azurerm_resource_group.cloud_2.name
  network_interface_ids = [azurerm_network_interface.main[each.key]]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
