variable "region" {
  type        = string
  description = "Set Provide Region"
  default     = "us-east-1"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "vpc-web"
}

variable "vpc_network" {
  type        = string
  description = "Set a Network to a VPC (e.g 192.168.0.0/16)"
  default     = "192.168.0.0/16"
}

variable "vpc_enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostnames (true/false)"
  default     = true
}

variable "igw_name" {
  type        = string
  description = "Internet Gateway Name"
  default     = "igw-web"
}

variable "route_igw_name" {
  type        = string
  description = "Internet Gateway Route Name"
  default     = "route-igw"
}

variable "route_default_cidr" {
  type        = string
  description = "Define the CIDR Block to the Internet Gateway and NAT Gateway as default route"
  default     = "0.0.0.0/0"
}

variable "private_subnet" {
  type        = map(any)
  description = "Define the Private subnet configurations"
  default = {
    private_subnet1 = {
      cidr_block        = "192.168.1.0/24",
      availability_zone = "us-east-1a"
    }
    private_subnet2 = {
      cidr_block        = "192.168.2.0/24",
      availability_zone = "us-east-1b"
    }
  }
}

variable "public_subnet" {
  type        = map(any)
  description = "Define the Public subnet configurations"
  default = {
    public_subnet1 = {
      cidr_block        = "192.168.3.0/24",
      availability_zone = "us-east-1a"
    }
    public_subnet2 = {
      cidr_block        = "192.168.4.0/24",
      availability_zone = "us-east-1b"
    }
  }
}

variable "natgw_name" {
  type        = string
  description = "NAT Gateway Name"
  default     = "nat-gw"
}

variable "route_natgw_name" {
  type        = string
  description = "NAT Gateway Route Name"
  default     = "route-natgw"
}

variable "sg_name" {
  type        = string
  description = "Security Group Name"
  default     = "fw-web"
}


