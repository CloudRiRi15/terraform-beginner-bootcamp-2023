terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "Cloud_RiRi-Terraform-beginner-Bootcamp"

    workspaces {
      name = "Terra-house-riri"
    }
  }
} 

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_forza_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.forza.public_path
  content_version = var.forza.content_version
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
  domain_name = module.home_forza_hosting.domain_name
  town = "missingo"
  content_version = var.forza.content_version
}

module "home_marlicomworld_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.marlicomworld.public_path
  content_version = var.marlicomworld.content_version
}
resource "terratowns_home" "home_marlicomworld" {
  name = "marlicomWorld International bringing you alive with great music"
  description = <<DESCRIPTION
  Weather you are feeling happy or sad, excited or anxious. Maybe you dont even know what 
  or how to feel anymore or you just numb. We got you. There is no easier way to get into 
  your feels than through the wonderful world of Music. Sit back and enjoy the vibrations 
  of amaing soul music or better yet put on your dancing shoes for some music funk. We got it All.
DESCRIPTION
  domain_name = module.home_marlicomworld_hosting.domain_name
  town = "missingo"
  content_version = var.marlicomworld.content_version
}