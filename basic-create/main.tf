provider "azurerm" {
  features {}
}

resource "azurerm_network_interface" "example" {
  name = "Test_Ubuntu_1-nic"
  location =  "westus2"
  resource_group_name = "Test_Ubuntu_1"
  ip_configuration {
    name = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id = "/subscriptions/51285dee-c1cd-4f73-bb11-d0c9323690cf/resourceGroups/Test_Ubuntu_1/providers/Microsoft.Network/virtualNetworks/Test_Ubuntu_1/subnets/Ubuntu_1Subnet"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name = "example-machine"
  resource_group_name = "Test_Ubuntu_1"
  location = "westus2"
  size = "Standard_B1s"
  disable_password_authentication = "false"
  admin_username = "adminuser"
  admin_password 	= "Nueva%123456"
  network_interface_ids = [azurerm_network_interface.example.id, ]
 
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}