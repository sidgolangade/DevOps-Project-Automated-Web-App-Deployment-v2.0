# Ansible module configuration

resource "aws_instance" "ansible_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y wget
    sudo yum install -y epel-release
    sudo yum install -y git
    sudo yum install -y python3 python3-pip
    sudo pip3 install ansible
    ansible-galaxy collection install ansible.posix

    sleep 120

    sudo cd /home/ec2-user/.ssh/
    sudo ssh-keygen -t rsa -b 4096 -C "ansible-control-machine" -q -N "" -f /home/ec2-user/.ssh/id_rsa
    sudo chmod 700 ~/.ssh
  EOF

  tags = {
    Name = "Ansible-Server"
  }
}

variable "instance_count" {
  description = "Number of Ansible instances to create"
  default     = 1
}

variable "ami" {
  description = "AMI ID for Ansible instance"
  default     = "ami-013d87f7217614e10"
}

variable "instance_type" {
  description = "Instance type for Ansible instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for Ansible instance"
  default     = "SG-Project-KP"
}
