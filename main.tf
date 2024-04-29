# Provider: AzureRM
provider "azurerm" {
  features {}
  use_oidc = true

}

# Randmon ID for resource group
resource "random_integer" "main" {
  min = 10000
  max = 99999
}

locals {
  resource_group_name = "${var.prefix}-${var.environment}-${random_integer.main.result}"
  environments = {
    development = {
      vnet_address_space = ["10.64.0.0/16"]
      subnets = {
        web = "10.64.0.0/24"
        app = "10.64.1.0/24"
      }
    }
    staging = {
      vnet_address_space = ["10.65.0.0/16"]
      subnets = {
        web = "10.65.0.0/24"
        app = "10.65.1.0/24"
      }
    }
    production = {
      vnet_address_space = ["10.66.0.0/16"]
      subnets = {
        web = "10.66.0.0/24"
        app = "10.66.1.0/24"
      }
    }
  }
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags = {
    environment = var.environment
    version     = "1.2"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = local.environments[var.environment].vnet_address_space

  tags = {
    environment = var.environment
  }
}

# Subnets
resource "azurerm_subnet" "main" {
  for_each = local.environments[var.environment].subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value]
}