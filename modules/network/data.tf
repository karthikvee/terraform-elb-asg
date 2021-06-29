data "aws_subnet_ids" "lb_subnets" {
  vpc_id     = aws_vpc.vpc_web.id
  depends_on = [aws_subnet.public_subnet]
  tags = {
    Network = "public"
  }
}
