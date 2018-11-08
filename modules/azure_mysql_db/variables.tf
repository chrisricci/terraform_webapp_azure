variable "location" {
  description = "Azure Location"
  type        = "string"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = "string"
}

variable "mysql_db_admin" {
  type        = "string"
}

variable "mysql_db_password" {
  type        = "string"
}

variable "mysql_db_name" {
  type        = "string"
}

variable "mysql_db_host" {
  type        = "string"
}

variable "lb_public_ip_address" {
  type        = "string"
}
