# Define AWS as our provider
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "/root/.aws/credentials"
  profile = "default"
}
