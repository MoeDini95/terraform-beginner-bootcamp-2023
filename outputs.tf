output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value = module.terrahouse_aws

}

output "s3_website_endpoint" {
  description = "s3·static·website·hosting·endpoint"
  value = module.terrahouse_aws.website_endpoint
}