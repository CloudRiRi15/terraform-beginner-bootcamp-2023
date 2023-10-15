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
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}
#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  assets_path = var.assets_path
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  index_html_filepath = var.index_html_filepath
#  error_html_filepath = var.error_html_filepath
#  content_version = var.content_version
#}

resource "terratowns_home" "home" {
  name = "Forza MotorSport- Car Racing at it's best!!"
  description = <<DESCRIPTION
Forza Motorsport was released on May 3, 2005, and is the first installment in the 
Forza Motorsport series. It is the only title in the series to be released on the 
original Xbox console.It features 231 cars and racetracks from 15 real-world and 
fictional locations. Here you get to witness the best of Forza Motorsport
with some of the fastest cars in action.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}