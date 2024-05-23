//
//
// virtual network variables
//
//

resource_group_name_network_name = "cloud_2_test"
resource_group_name_network_location = "West Europe"
resource_group_name_network_address = ["10.0.0.0/16"]

//
//
// virtual network subnet internals variables
//
//
azurerm_subnet_name = "internal"
azurerm_subnet_name_resource_group_name = "cloud_2_test"
azurerm_subnet_virtual_network_name = "main"
azurerm_subnet_address_prefixes = ["10.0.2.0/24"]
