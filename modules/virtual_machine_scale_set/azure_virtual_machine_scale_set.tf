resource "azurerm_virtual_network" "network1" {
  name                = "network1"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.network1.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "interface1" {
  name                = "interface1"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.subnet1.id}"
    private_ip_address_allocation = "dynamic"
  }
}

data "template_file" "init_script" {
  template = "${file("${path.module}/resources/init_script.sh")}"

  vars {
    mysql_db_admin    = "${var.mysql_db_admin}"
    mysql_db_password = "${var.mysql_db_password}"
    mysql_db_name     = "${var.mysql_db_name}"
    mysql_db_host     = "${var.mysql_db_host}"
  }
}

resource "azurerm_virtual_machine_scale_set" "test" {
  name                = "webappscaleset-1"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  upgrade_policy_mode = "Automatic"

  sku {
    name     = "Standard_A2"
    tier     = "Standard"
    capacity = "${var.node_count}"
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
      lun          = 0
    caching        = "ReadWrite"
    create_option  = "Empty"
    disk_size_gb   = 10
  }

  os_profile {
    computer_name_prefix = "testvm"
    admin_username       = "${var.admin_username}"
    admin_password       = "${var.admin_password}"
    custom_data          = "${data.template_file.init_script.rendered}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/id_rsa.pub")}"
    }
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      subnet_id                              = "${azurerm_subnet.subnet1.id}"
      load_balancer_backend_address_pool_ids = ["${var.lb_backend_address_pool}"]
      load_balancer_inbound_nat_rules_ids    = ["${var.lb_nat_pool[count.index]}"]
    }
  }

  tags {
    environment = "staging"
  }
}