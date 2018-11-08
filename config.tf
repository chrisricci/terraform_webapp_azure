variable "location" {
  description = "Azure Location"
  type        = "string"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = "string"
}

variable "admin_username" {
  description = "admin username"
  type        = "string"
}

variable "admin_password" {
  description = "admin password"
  type        = "string"
}

variable "node_count" {
  description = "number of nodes in the scale set"
  type        = "string"
}

variable "mysql_db_admin" {
  type       = "string"
}

variable "mysql_db_password" {
  description = "admin username"
  type        = "string"
}

variable "mysql_db_name" {
  description = "admin password"
  type        = "string"
}

variable "mysql_db_host" {
  description = "admin password"
  type        = "string"
}