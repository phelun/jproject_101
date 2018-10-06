# Configure the Terraform backend
terraform {
  backend "s3" {
    bucket = "brexit4u-iac"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}

# Get the latest Amazon Linux AMI
data "aws_ami" "amzn_linux" {
  most_recent = true

  filter {
    name = "status"
    values = ["available"]
  }

  filter {
    name = "tag:environ"
    values = ["dev"]
  }
}


