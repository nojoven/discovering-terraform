provider "aws" {
  region = "eu-west-3"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# resource "aws_instance" "web" {
#   count         = 5
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"
#   user_data     = <<-EOF
#   #!/bin/bash
# sudo apt-get update
# sudo apt-get install nginx -y
# sudo service nginx start
# EOF

#  tags = {
#    Name = "Nginx-webserver"
#  }
# }