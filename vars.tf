variable "AWS_ACCESS_KEY_ID" {
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  default = ""
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-3548444c"
    us-west-2 = "ami-4c457735"
    eu-west-1 = "ami-1caef165"
  }
}
