variable "location" {
  description = "Azure Location"
  type        = "string"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = "string"
}

variable "node_count" {
  description = "number of nodes in the scale set"
  type        = "string"
}
