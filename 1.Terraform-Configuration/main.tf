provider "aws" {
  region = "eu-west-1"  # AWS Region
}

module "jenkins" {
  source = "./Modules/Jenkins"  # Jenkins module directory path

  instance_count = 1
  ami           = "ami-013d87f7217614e10"
  instance_type = "t2.micro"
  key_name      = "SG-Project-KP"
}

module "ansible" {
  source = "./Modules/Ansible"  # Ansible module directory path

  instance_count = 1
  ami           = "ami-013d87f7217614e10"
  instance_type = "t2.micro"
  key_name      = "SG-Project-KP"
}

