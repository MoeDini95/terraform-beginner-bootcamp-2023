terraform  {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }


# cloud {
#    organization = "MoeDini95"

#    workspaces {
#     name = "terra-house-95"
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
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}


resource "terratowns_home" "home" {
  name = "Why Castlevania is the best animated show!"
  description = <<DESCRIPTION
Castlevania is an animated show that aired on Netflix from 2017 to 2021. 
It is a show about a Vampire hunter who has a main goal of eliminating Dracula and his army.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}