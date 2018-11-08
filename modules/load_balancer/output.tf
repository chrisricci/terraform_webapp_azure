output "lb_backend_address_pool" {
  value = "${azurerm_lb_backend_address_pool.bpepool.id}"
}

output "lb_nat_pool" {
  value = "${azurerm_lb_nat_pool.lbnatpool.*.id}"
}

output "lb_public_ip_address" {
  value = "${azurerm_public_ip.publicip1.ip_address}"
}
