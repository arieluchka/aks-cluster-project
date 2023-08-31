terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "db_resource" {
  name     = "${var.db_name}-resource-group"
  location = var.location
}

resource "azurerm_virtual_network" "db_vnet" {
  name                = "${var.db_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.db_resource.name
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.db_name}-subnet1"
  resource_group_name  = azurerm_resource_group.db_resource.name
  virtual_network_name = azurerm_virtual_network.db_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "db_pip" {
  name                    = "${var.db_name}-pip"
  location                = var.location
  resource_group_name     = azurerm_resource_group.db_resource.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "db_nic" {
  name                = "${var.db_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.db_resource.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.db_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.db_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "db-vm" {
  name                = "${var.db_name}-vm"
  resource_group_name = azurerm_resource_group.db_resource.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.db_username
  admin_password = var.db_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.db_nic.id,
  ]

  # admin_ssh_key {
  #   username   = "arieluchka"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_network_security_group" "db_nsg" {
  name                = "${var.db_name}-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.db_resource.name

  # security_rule {
  #     name = "allow-ssh-and-80"
  #     priority = 150
  #     direction = "Inbound"
  #     access = "Allow"
  #     source_port_range = ["22"]
  #     destination_port_ranges = ["22"]
  #     source_address_prefix = "*"
  #     destination_address_prefix = "*"
  #   }
  #   # {
  #   #   name = "test"
  #   #   priority = 151
  #   #   direction = "Inbound"
  #   #   access = "Allow"
  #   #   source_port_range = "443"
  #   #   destination_port_ranges = "443"
  #   #   source_address_prefix = "*"
  #   #   destination_address_prefix = "*"
  #   # }
}

resource "azurerm_network_security_rule" "allow22" {
  name = "allow-22"
  priority = 150
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["22", "80"]
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.db_resource.name
  network_security_group_name = azurerm_network_security_group.db_nsg.name
}