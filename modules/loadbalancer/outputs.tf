output "loadbalancer_dns" {
  value = aws_lb.lb_web.dns_name
}

output "lb_tg" {
  value = aws_lb_target_group.lb_tg.arn
}
