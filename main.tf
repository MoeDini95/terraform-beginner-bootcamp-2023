terraform  {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }


#backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-95"
  #  }
  #}

 cloud {
    organization = "MoeDini95"

    workspaces {
    name = "terra-house-95"
    }
  }






}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}






module "home_castle" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.castle.public_path
  bucket_name = var.bucket_name
  content_version = var.castle_content_version
}


resource "terratowns_home" "home" {
  name = "Why Castlevania is the best animated show!"
  description = <<DESCRIPTION
Castlevania is an animated show that aired on Netflix from 2017 to 2021. 
It is a show about a Vampire hunter who has a main goal of eliminating Dracula and his army.
DESCRIPTION
  domain_name = module.home_castle.domain_name
  town = "missingo"
  content_version = var.castle_content_version
}

module "home_canada" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.canada.public_path
  bucket_name = var.bucket_name
  content_version = var.canada_content_version
}


resource "terratowns_home" "home" {
  name = "Views of Canada"
  description = <<DESCRIPTION
Being in Canada has a lot of advantages and one of the major advantages are its beautiful views.
DESCRIPTION
  domain_name = module.home_canada.domain_name
  town = "missingo"
  content_version = var.canada_content_version
}