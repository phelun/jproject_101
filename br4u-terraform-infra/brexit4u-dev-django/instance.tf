resource "aws_instance" "example" {
  ami           = "${data.aws_ami.amzn_linux.image_id}"
  instance_type = "t2.micro"
}
