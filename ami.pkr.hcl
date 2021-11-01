packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "webapp-ubuntu" {
  ami_name      = "Webapp-Ubuntu"
  ami_users = var.ami_users
  instance_type = "t2.micro"
  region        = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  source_ami = var.source_ami
  force_deregister =  true
  force_delete_snapshot = true
  ssh_username = "ubuntu"
  ami_description = "Ubuntu AMI for CSYE6225"
  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "gp2"
    delete_on_termination = true
  }
}

build {
  name    = "webapp-ami"
  sources = [
    "source.amazon-ebs.webapp-ubuntu"
  ]
  provisioner "shell" {
    script = "setup.bash"
  }
}