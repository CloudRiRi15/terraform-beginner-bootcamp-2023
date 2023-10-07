terraform {
#  cloud {
#    organization = "Cloud_RiRi-Terraform-beginner-Bootcamp"
#
#    workspaces {
#      name = "Terra-house-riri"
#    }
#  }

}  
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}