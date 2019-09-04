##################################################################################
# PROVIDERS
##################################################################################
provider "aws" {
  region     = "eu-west-2"
  version    = "~> 2.23.0"
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "conc_sec_group" {
  name        = "${local.common_name_prefix}_allow_https_ssh_access_SG"
  description = "Allow http, https and SSH for ${local.common_name_prefix}"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, map("Name", "${local.common_name_prefix}-vpc"))
}


data "aws_ami" "bastion_instance_ami_ic" {
  most_recent = true
  owners = [
    "137112412989",
  ]
  name_regex = ".*amzn2-ami-hvm-2.0.*"

  filter {
    name = "architecture"
    values = [
      "x86_64",
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm",
    ]
  }
}

resource "aws_instance" "nginx" {
  ami                         = data.aws_ami.bastion_instance_ami_ic.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  security_groups             = [aws_security_group.conc_sec_group.name]
  associate_public_ip_address = true

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install nginx1.12 -y",
      "sudo service nginx start",
    ]
  }

  tags = merge(local.common_tags, map("Name", "${local.common_name_prefix}-nginx-instance"))
}



