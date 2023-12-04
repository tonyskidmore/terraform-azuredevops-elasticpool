terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.1.0"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.10.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azuredevops" {
  org_service_url       = var.ado_org
  personal_access_token = var.ado_token
}

provider "azurerm" {
  features {}
}
