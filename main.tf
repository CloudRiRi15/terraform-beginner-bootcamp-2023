terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
#  cloud {
#    organization = "Cloud_RiRi-Terraform-beginner-Bootcamp"
#
#    workspaces {
#      name = "Terra-house-riri"
#    }
#  }

} 

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  assets_path = var.assets_path
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
}

resource "terratowns_home" "home" {
  name = "Forza MotorSport- Car Racing at it's best!!"
  description = <<DESCRIPTION
Forza Motorsport was released on May 3, 2005, and is the first installment in the 
Forza Motorsport series. It is the only title in the series to be released on the 
original Xbox console.It features 231 cars and racetracks from 15 real-world and 
fictional locations. Here you get to witness the best of Forza Motorsport
with some of the fastest cars in action.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fhskn3.cloudfront.net"
  town = "missingo"
  content_version = 1
}