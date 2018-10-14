resource "aws_instance" "dev_inst" {
  ami           = "${data.aws_ami.amzn_linux.image_id}"
  instance_type = "t2.micro"
  #count = 3
}
