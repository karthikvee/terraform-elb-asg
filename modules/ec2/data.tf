data "aws_ami" "image_ec2" {
  owners      = var.image_owners
  most_recent = var.ami_most_recent
  filter {
    name   = var.filter_ami_fieldname
    values = var.filter_ami_value
  }
}

