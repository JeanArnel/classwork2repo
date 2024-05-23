//virtual_machines_config = yamldecode(file("${path.module}/configs/virtual_machines.yaml"))
virtual_machines_map = { for vm in local.virtual_machines_config.virtual_machines : vm.name => vm }
address_space = ["10.0.0.0/16"]
subnet_prefix = ["10.0.2.0/24"]
vm_size = "Standard_DS1_v2"
  os_publisher = "Canonical"
  os_offer     = "0001-com-ubuntu-server-jammy"
  os_sku       = "22_04-lts"
  os_version   = "latest"
}
