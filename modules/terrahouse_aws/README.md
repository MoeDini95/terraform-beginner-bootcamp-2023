## Terrahouse AWS

The following directory 

```tf
module "home_canada" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.canada_public_path
  bucket_name = var.bucket_name
  content_version = var.content_version
}
```

The public directory expects the following:
- index.html 
- error.html 
- assets 

All top level files in the assets will be copied, but not any subdirectories. 