output "vpc_id" {
  value = aws_vpc.vpc_web.id
}

output "private_subnet1_id" {
  value = aws_subnet.private_subnet["private_subnet1"].id
}

output "private_subnet" {
  value = aws_subnet.private_subnet
}

output "public_subnet1_id" {
  value = aws_subnet.public_subnet["public_subnet1"].id
}

output "public_subnet" {
  value = aws_subnet.public_subnet
}

output "security_group_ids" {
  value = aws_security_group.fw_web.id
}


output "aws_lb_subnet" {
  value = data.aws_subnet_ids.lb_subnets
}

