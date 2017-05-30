
variable "region" {
  description = "AWS region"
  default = "us-west-2"
}


variable "environment" {
  default = "dev"
}
variable "bastion_ami" {
  default = "ami-efd0428f"
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

variable "name" {
  description = "Application name used to name resources etc."
  default = "madhav-test"
}


variable "az_count" {
  default = 2
}

variable "ssh_key_name" {
  default = "ssh-test"
}
