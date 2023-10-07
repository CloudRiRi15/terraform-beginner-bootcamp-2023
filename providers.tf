terraform {
#  cloud {
#    organization = "Cloud_RiRi-Terraform-beginner-Bootcamp"
#
#    workspaces {
#      name = "Terra-house-riri"
#    }
#  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}  

provider "aws" {
  # Configuration options
}
provider "random" {
  # Configuration options
}