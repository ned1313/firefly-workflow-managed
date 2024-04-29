terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  cloud {
    # Provide values at runtime
    # TF_CLOUD_ORGANIZATION
    # TF_WORKSPACE
  }
}