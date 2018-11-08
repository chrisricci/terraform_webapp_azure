output "azure_mysql_server_name" {
  value = "${azurerm_mysql_server.mysqlserver1.name}"
}

output "azure_mysql_server_fqdn" {
  value = "${azurerm_mysql_server.mysqlserver1.fqdn}"
}
