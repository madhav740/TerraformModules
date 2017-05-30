###########################################
#Create Bastion Host ASG
###########################################
data "aws_availability_zones" "available" {}
resource "aws_autoscaling_group" "bastion-asg" {
  availability_zones = [ "${data.aws_availability_zones.available.names[0]}" ]
  name = "YAM_Migration-Bastion-Asg"
  min_size = "0"
  max_size = "0"
  health_check_type = "EC2"
  launch_configuration = "${aws_launch_configuration.bastion-lc.name}"
  vpc_zone_identifier = [ "subnet-d4752ca2" ]

  
  lifecycle {
    create_before_destroy = true
  }

  tag = [
    {
      key = "Application"
      value = "BastionHost"
      propagate_at_launch = true
    },
    {
      key = "Environment"
      value = "${var.environment}"
      propagate_at_launch = true
    },
    {
      key = "Terraform"
      value = "true"
      propagate_at_launch = true
    }
  ]
}

###########################################
#Create Bastion Host LC
###########################################

resource "aws_launch_configuration" "bastion-lc" {
  name_prefix = "yam-migration-bastion-lc"
  image_id = "${var.bastion_ami}"
  instance_type = "${var.bastion_instance_type}"
  security_groups = [ "sg-49e2bc32" ]
  iam_instance_profile = "bastion-iam"
  key_name = "ssh-test"
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
}
