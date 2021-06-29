provider "aws" {
  region             = "us-east-1"
}

locals {
  env               = "stage"
  region            = "us-east-1"
}

module "instance" {
  source             = "../../modules/ec2"
  s3_access_role_name = module.iam_role.s3_access_role_name
  sg_ids             = module.network.security_group_ids
  private_subnet_id  = module.network.private_subnet1_id
  private_subnet     = module.network.private_subnet
  lb_tg              = module.loadbalancer.lb_tg
  region             = local.region
  instance_profile_name = "s3_access_profile-ec2-${local.env}"
  ec2_name           = "instance-web-${local.env}"
  ec2_type           = "t2.micro"
  launch_configuration_name = "lc-web-${local.env}" 
}

module "iam_role" {
  source             = "../../modules/iam"
  region             = local.region
  s3_role_name       = "s3-access-role-${local.env}"
}

module "loadbalancer" {
  source             = "../../modules/loadbalancer"
  region             = local.region
  loadbalancer_name  = "web-lb-${local.env}"
  loadbalancer_targetgroup_name = "lb-tg-web-${local.env}"
  loadbalancer_port  = 80
  vpc_id             = module.network.vpc_id
  sg_ids             = module.network.security_group_ids
  instace_web_id     = module.instance.instace_web_id
  public_subnet      = module.network.public_subnet 
}

module "network" {
  source            = "../../modules/network"
  region             = local.region
  vpc_network       = "192.168.0.0/16"
  igw_name          = "igw-web-${local.env}"
  route_igw_name    = "route-igw-${local.env}"
  natgw_name        = "nat-gw-${local.env}"
  route_natgw_name  = "route-natgw-${local.env}"
  sg_name           =  "fw-web-${local.env}"
}
