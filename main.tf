#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-958128fa
#
# Your subnet ID is:
#
#     subnet-e34cbc88
#
# Your security group ID is:
#
#     sg-73a74919
#
# Your Identity is:
#
#     terraform-training-jellyfish
#

terraform {
  backend "atlas" {
    name = "aaalex/training"
  }
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type    = "string"
  default = "eu-central-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}


resource "aws_instance" "web" {
  count = "2"
  ami                    = "ami-958128fa"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-e34cbc88"
  vpc_security_group_ids = ["sg-73a74919"]

  tags {
    Identity = "terraform-training-jellyfish"
    tag2     = "tag"
    tag3     = "bla"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
