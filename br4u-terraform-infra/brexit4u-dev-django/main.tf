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
    name = "owner-alias"
    values = ["658951324167"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
}

# Create an EC2 instance
#resource "aws_instance" "example" {
#  ami = "${data.aws_ami.amzn_linux.image_id}"
#  instance_type = "t2.micro"
#  key_name = "${var.key_pair_name}"
#
#  tags {
#    Name = "${var.ec2_name}"
#  }
#}
