output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value = module.home_castle.bucket_name

}

output "s3_website_endpoint" {
  description = "s3·static·website·hosting·endpoint"
  value = module.terrahouse_aws.website_endpoint

}

output "cloudfront_url" {
  description = "This CloudFront Distribution Domain Name"
  value = module.home_castle.domain_name 
}