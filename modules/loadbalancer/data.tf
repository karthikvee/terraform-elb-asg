data "aws_subnet_ids" "lb_subnets" {
  vpc_id     = var.vpc_id
  depends_on = [var.public_subnet]
  tags = {
    Network = "public"
  }
}
