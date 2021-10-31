packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "webapp-ubuntu" {
  ami_name      = var.ami_name
  ami_users = var.ami_users
  instance_type = var.instance_type
  region        = var.region
  profile = var.profile
  source_ami = var.source_ami
  ssh_username = var.ssh_username
  ami_description = var.ami_description
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