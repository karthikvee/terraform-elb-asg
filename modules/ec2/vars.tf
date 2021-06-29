variable "region" {
  type        = string
  description = "Set Provide Region"
  default     = "us-east-1"
}

variable "s3_access_role_name" {
  type         = string
  description  = "s3 role name"
}

variable "lb_tg" {
  type        = string
  description = "lb target group"
}

variable "image_owners" {
  type        = list(string)
  description = "List with AMI Owners (default - Debian ID)"
  default     = ["136693071363"]
}

variable "ami_most_recent" {
  type        = bool
  description = "AMI Most Recent (true/false)"
  default     = true
}

variable "filter_ami_fieldname" {
  type        = string
  description = "Field name to using on AMI Filter"
  default     = "name"
}

variable "filter_ami_value" {
  type        = list(string)
  description = "Value list to filter AMI"
  default     = ["debian-10-amd64-*"]
}

variable "private_subnet_id" {
 type         = string
 description  = "private subnet id"
}

variable "private_subnet" {
 description  = "private subnet list"
}

variable "sg_ids" {
 type        = string
 description = "security group ids"
}

variable "instance_profile_name" {
  type        = string
  description = "IAM Instance profile Name"
  default     = "s3_access_profile-ec2"
}

variable "ec2_name" {
  type        = string
  description = "EC2 Name"
  default     = "instance-web"
}

variable "ec2_type" {
  type        = string
  description = "EC2 Type"
  default     = "t2.micro"
}

variable "userdata_file_path" {
  type        = string
  description = "User data file path (e.g /path/script.sh)"
  default     = "files/apache.sh"
}

variable "launch_configuration_name" {
  type        = string
  description = "Launch Configuration Name"
  default     = "lc-web"
}

variable "autoscaling_group" {
  type        = map(any)
  description = "Autoscaling group configurations"
  default = {
    name              = "ag-web"
    max_size          = 3
    min_size          = 1
    desired_capacity  = 1
    health_check_type = "EC2"
  }
}

variable "autoscaling_policy" {
  type        = map(any)
  description = "Autoscaling policy configurations"
  default = {
    "ag_scale_up" = {
      scaling_adjustment = 1
      adjustment_type    = "ChangeInCapacity"
      cooldown           = 300
    }
    "ag_scale_down" = {
      scaling_adjustment = -1
      adjustment_type    = "ChangeInCapacity"
      cooldown           = 300
    }
  }
}

variable "autoscaling_alarm" {
  type        = map(any)
  description = "Autoscaling alarm configurations"
  default = {
    "ag_metric_up" = {
      comparison_operator = "GreaterThanThreshold"
      metric_name         = "CPUUtilization"
      threshold           = 80
      statistic           = "Average"
      evaluation_periods  = 2
      namespace           = "AWS/EC2"
      period              = 120
      alarm_actions       = "ag_scale_up"
    }
    "ag_metric_down" = {
      comparison_operator = "LessThanThreshold"
      metric_name         = "CPUUtilization"
      threshold           = 60
      statistic           = "Average"
      evaluation_periods  = 2
      namespace           = "AWS/EC2"
      period              = 300
      alarm_actions       = "ag_scale_down"
    }
  }
}

