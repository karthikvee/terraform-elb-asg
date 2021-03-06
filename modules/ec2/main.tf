resource "aws_iam_instance_profile" "s3_access_profile" {
  name = var.instance_profile_name
  role = var.s3_access_role_name
}

resource "time_sleep" "wait_time" {
  create_duration = "1m"
}

resource "aws_instance" "instace_web" {
  ami                    = data.aws_ami.image_ec2.id
  instance_type          = var.ec2_type
  subnet_id              = var.private_subnet_id 
  vpc_security_group_ids = [var.sg_ids]
  iam_instance_profile   = aws_iam_instance_profile.s3_access_profile.id  
  depends_on             = [time_sleep.wait_time]
  tags                   = { Name = var.ec2_name }
}

resource "aws_launch_configuration" "lc_web" {
  name                 = var.launch_configuration_name
  image_id             = data.aws_ami.image_ec2.id
  instance_type        = var.ec2_type
  iam_instance_profile = aws_iam_instance_profile.s3_access_profile.id
#  user_data            = file(var.userdata_file_path)
  security_groups      = [var.sg_ids]
}

locals {
  subnets = [for subnet in var.private_subnet : subnet.id]
}

resource "aws_autoscaling_group" "ag_web" {
  name                 = var.autoscaling_group["name"]
  max_size             = var.autoscaling_group["max_size"]
  min_size             = var.autoscaling_group["min_size"]
  desired_capacity     = var.autoscaling_group["desired_capacity"]
  health_check_type    = var.autoscaling_group["health_check_type"]
  launch_configuration = aws_launch_configuration.lc_web.name
  target_group_arns    = [var.lb_tg]
  vpc_zone_identifier  = local.subnets
  depends_on           = [time_sleep.wait_time]
}

resource "aws_autoscaling_policy" "ag_scale" {
  for_each               = var.autoscaling_policy
  name                   = each.key
  scaling_adjustment     = each.value.scaling_adjustment
  adjustment_type        = each.value.adjustment_type
  cooldown               = each.value.cooldown
  autoscaling_group_name = aws_autoscaling_group.ag_web.name
}

resource "aws_cloudwatch_metric_alarm" "ag_metric" {
  for_each            = var.autoscaling_alarm
  alarm_name          = each.key
  comparison_operator = each.value.comparison_operator
  metric_name         = each.value.metric_name
  threshold           = each.value.threshold
  statistic           = each.value.statistic
  evaluation_periods  = each.value.evaluation_periods
  namespace           = each.value.namespace
  period              = each.value.period
  alarm_actions       = [aws_autoscaling_policy.ag_scale[each.value.alarm_actions].arn]
  dimensions          = { AutoScalingGroupName = aws_autoscaling_group.ag_web.name }
}

