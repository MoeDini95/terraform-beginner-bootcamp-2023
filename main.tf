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
  endpoint = "http://localhost:4567/api"
  user_uuid= "e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token= "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}
#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  error_html_filepath = var.error_html_filepath
#  index_html_filepath = var.index_html_filepath
#  content_version = var.content_version
#}

#resource "terratowns_home" "home" {
#  name = "Why Castlevania is the best animated show"
#  description = "Castlevania is an animated show that aired on Netflix from 2017 to 2021. It is a show about a Vampire hunter who has a main goal of eliminating Dracula and his army."
#    #domain_name = module.terrahouse_aws.cloudfront_url
#    domain_name = "4rhfgry6.cloudfront.net"
#    town = "gamers-grotto"
#    content_version = 1
  
#}

resource "terratowns_home" "home" {
  name = "Why Castlevania is the best animated show!"
  description = <<DESCRIPTION
Castlevania is an animated show that aired on Netflix from 2017 to 2021. 
It is a show about a Vampire hunter who has a main goal of eliminating Dracula and his army.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "4rhfgry6.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}