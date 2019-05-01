# Define AWS as our provider
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "/root/.aws/credentials"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  profile = "default"
}
