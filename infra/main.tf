# Resource Group
resource "azurerm_resource_group" "wcmt" {
  name     = "wcmt"
  location = var.rg_location
}

# Network
resource "azurerm_virtual_network" "network" {
  name                = "wcmt-network"
  address_space       = var.network_address_space
  location            = azurerm_resource_group.wcmt.location
  resource_group_name = azurerm_resource_group.wcmt.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "wcmt-subnet"
  resource_group_name  = azurerm_resource_group.wcmt.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_interface" "network_interface" {
  name                = "wcmt-nic"
  location            = azurerm_resource_group.wcmt.location
  resource_group_name = azurerm_resource_group.wcmt.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Linux VM
resource "azurerm_linux_virtual_machine" "wcmt_vm" {
  name                = "wcmt-vm"
  resource_group_name = azurerm_resource_group.wcmt.name
  location            = azurerm_resource_group.wcmt.location
  size                = var.vm_size
  admin_username      = var.vm_adminuser
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  admin_ssh_key {
    username   = var.vm_adminuser
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = lookup(var.vm_os_disk, "caching", "ReadWrite")
    storage_account_type = lookup(var.vm_os_disk, "storage_account_type", "Standard_LRS")
  }

  source_image_reference {
    publisher = lookup(var.vm_source_image_reference, "publisher", "Canonical")
    offer     = lookup(var.vm_source_image_reference, "offer", "UbuntuServer")
    sku       = lookup(var.vm_source_image_reference, "sku", "16.04-LTS")
    version   = lookup(var.vm_source_image_reference, "version", "latest")
  }
}
