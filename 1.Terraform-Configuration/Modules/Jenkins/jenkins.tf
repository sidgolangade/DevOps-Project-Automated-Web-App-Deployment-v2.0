# Jenkins module configuration

resource "aws_instance" "jenkins_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y wget
    sudo yum install -y git
    sudo yum install -y java-17-openjdk

    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum install -y jenkins
    sudo systemctl daemon-reload
    sudo systemctl enable jenkins

    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo groupadd docker
    sudo usermod -aG docker jenkins
    sudo systemctl restart jenkins

    sudo yum install python3.11
    sudo yum install python3.11-pip
    sudo pip install pytest pytest-django

    sudo mkdir -p /var/lib/jenkins/test-reports
    sudo chown jenkins:jenkins /var/lib/jenkins/test-reports
    
    sleep 120

    sudo cd /home/ec2-user/.ssh/
    sudo ssh-keygen -t rsa -b 4096 -C "jenkins-control-machine" -q -N "" -f /home/ec2-user/.ssh/id_rsa
    sudo chmod 700 ~/.ssh
  EOF

  tags = {
    Name = "Jenkins-Server"
  }
}

variable "instance_count" {
  description = "Number of Jenkins instances to create"
  default     = 1
}

variable "ami" {
  description = "AMI ID for Jenkins instance"
  default     = "ami-013d87f7217614e10"
}

variable "instance_type" {
  description = "Instance type for Jenkins instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for Jenkins instance"
  default     = "SG-Project-KP"
}
