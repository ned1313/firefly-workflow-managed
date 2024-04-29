variable "environment" {
  type        = string
  description = "Environment value to use for tagging resources"
}

variable "location" {
  type        = string
  description = "Location value to use for Azure resources"
  default     = "eastus"
}

variable "prefix" {
  type        = string
  description = "Prefix value to use for Azure resources"
  default     = "nacho"
}