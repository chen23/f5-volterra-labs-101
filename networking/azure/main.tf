
provider "azurerm" {
   # subscription_id = "${var.subscription_id}"
   # client_id       = "${var.client_id}"
   # client_secret   = "${var.client_secret}"
   # tenant_id       = "${var.tenant_id}"
   features {}
 }

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}


resource "azurerm_network_security_group" "f5demo" {
  name                = "f5demo_nsg"
  resource_group_name     = "${var.resource_group}"
  location = "${var.location}"
}


resource "azurerm_network_security_rule" "f5demo" {
  name                        = "allow_trusted"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "141.156.165.123/32"
  destination_address_prefix  = "*"
  resource_group_name     = "${var.resource_group}"  
  network_security_group_name = azurerm_network_security_group.f5demo.name
}

resource "azurerm_virtual_network" "f5demo" {
  name                = "f5demo_vnet"
  location            = "${var.location}"
  address_space       = ["10.2.0.0/16"]
  resource_group_name = "${azurerm_resource_group.rg.name}"
}


resource "azurerm_subnet" "external" {
  name = "external_subnet"
  virtual_network_name = "${azurerm_virtual_network.f5demo.name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_prefixes   = ["10.2.0.0/24"]
}

resource "azurerm_subnet" "internal" {
  name = "internal_subnet"
  virtual_network_name = "${azurerm_virtual_network.f5demo.name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_prefixes   = ["10.2.1.0/24"]
#  route_table_id = "${azurerm_route_table.f5demo_transfer_rt.id}"
}

resource "azurerm_subnet" "workload" {
  name = "workload_subnet"
  virtual_network_name = "${azurerm_virtual_network.f5demo.name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_prefixes   = ["10.2.2.0/24"]
}

resource "azurerm_route_table" "workload" {
  name                = "workload_rt"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_subnet_route_table_association" "workload" {
  subnet_id      = azurerm_subnet.workload.id
  route_table_id = azurerm_route_table.workload.id
}