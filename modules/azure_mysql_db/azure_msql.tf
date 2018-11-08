resource "azurerm_mysql_server" "mysqlserver1" {
  name                = "${var.mysql_db_host}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  sku {
    name = "MYSQLB50"
    capacity = 50
    tier = "Basic"
  }

  administrator_login = "${var.mysql_db_admin}"
  administrator_login_password = "${var.mysql_db_password}"
  version = "5.7"
  storage_mb = "51200"
  ssl_enforcement = "Disabled"
}

resource "azurerm_mysql_database" "mysqldb1" {
  name                = "${var.mysql_db_name}"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_mysql_server.mysqlserver1.name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "test" {
  name                = "webappservers"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_mysql_server.mysqlserver1.name}"
  start_ip_address    = "${var.lb_public_ip_address}"
  end_ip_address      = "${var.lb_public_ip_address}"
}