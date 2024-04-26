terraform {
   required_version = ">= 0.12"
   required_providers {
      azurerm = ">2.5"
   }
}

provider "azurerm" {
   
   features {}
}
variable "location" {
   type = string
   description = "Region"
   default = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Nom du groupe de ressources Azure"
  default     = "Groupe3-Brief15"
}


