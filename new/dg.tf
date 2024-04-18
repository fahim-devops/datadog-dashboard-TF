# main.tf

terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
    }
  }
}

# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

variable "datadog_api_key" {
  default = "<YOUR_API_KEY>"
}

variable "datadog_app_key" {
  default = "<YOUR_APPLICATION_KEY>"
}