resource "aws_lb" "lb_web" {
  name               = var.loadbalancer_name
  load_balancer_type = var.loadbalancer_type
  security_groups    = [var.sg_ids]
  subnets            = data.aws_subnet_ids.lb_subnets.ids
  internal           = false
}

resource "aws_lb_target_group" "lb_tg" {
  name     = var.loadbalancer_targetgroup_name
  port     = var.loadbalancer_port
  protocol = var.loadbalancer_protocol
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tg_attach" {
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id        = var.instace_web_id
  port             = var.loadbalancer_port
}

resource "aws_lb_listener" "lb_backend" {
  load_balancer_arn = aws_lb.lb_web.arn
  port              = var.loadbalancer_port
  protocol          = var.loadbalancer_protocol

  default_action {
    type             = var.lb_action_type
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}

