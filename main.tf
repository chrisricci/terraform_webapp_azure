module "azure_virtual_machine_scale_set" {
  source = "modules/virtual_machine_scale_set"

  resource_group_name     = "${var.resource_group_name}"
  location                = "${var.location}"
  node_count              = "${var.node_count}"
  lb_nat_pool             = "${module.azure_loadbalancer.lb_nat_pool}"
  lb_backend_address_pool = "${module.azure_loadbalancer.lb_backend_address_pool}"
  admin_username          = "${var.admin_username}"
  admin_password          = "${var.admin_password}"
  mysql_db_host           = "${module.azure_mysql_db.azure_mysql_server_fqdn}"
  mysql_db_name           = "${var.mysql_db_name}"
  mysql_db_admin          = "${var.mysql_db_admin}@${var.mysql_db_host}"
  mysql_db_password       = "${var.mysql_db_password}"
}

module "azure_loadbalancer" {
  source = "modules/load_balancer"

  resource_group_name  = "${var.resource_group_name}"
  location             = "${var.location}" 
  node_count           = "${var.node_count}"
}

module "azure_mysql_db" {
  source = "modules/azure_mysql_db"

  resource_group_name     = "${var.resource_group_name}"
  location                = "${var.location}"
  mysql_db_admin          = "${var.mysql_db_admin}"
  mysql_db_password       = "${var.mysql_db_password}"
  mysql_db_name           = "${var.mysql_db_name}"
  mysql_db_host           = "${var.mysql_db_host}"
  lb_public_ip_address    = "${module.azure_loadbalancer.lb_public_ip_address}"
}