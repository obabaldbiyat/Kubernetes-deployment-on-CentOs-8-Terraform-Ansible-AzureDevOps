# Create (and display) an SSH key
resource "tls_private_key" "SSH" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create 2 VMs Worker
 resource "azurerm_linux_virtual_machine" "test" {
    count                 = 2
    name                  = "worker${count.index}"
    location              = var.location
    resource_group_name   = var.resource_group_name
    size                  = "Standard_D2ds_v4"
    network_interface_ids = [
     azurerm_network_interface.test["${count.index}"].id
    ]

    source_image_reference {
     publisher = "OpenLogic"
     offer     = "CentOS"
     sku       = "8_5-gen2"
     version   = "latest"
    }

    computer_name                   = "worker${count.index}"
    admin_username                  = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
      username   = "azureuser"
      public_key = tls_private_key.SSH.public_key_openssh
   }

    os_disk {
      name = "OSdisk${count.index}"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
}

# Create 1 VM Manager
 resource "azurerm_linux_virtual_machine" "Manager" {
    name                  = "manager"
    location              = var.location
    resource_group_name   = var.resource_group_name
    size                  = "Standard_D2ds_v4"
    network_interface_ids = [
     azurerm_network_interface.test["${2}"].id
     ]

    source_image_reference {
     publisher = "OpenLogic"
     offer     = "CentOS"
     sku       = "8_5-gen2"
     version   = "latest"
    }

    computer_name                   = "manager"
    admin_username                  = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
     username   = "azureuser"
     public_key = tls_private_key.SSH.public_key_openssh
    }

    os_disk {
      name = "OSdisk"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    depends_on = [var.resource_group_name]
}
