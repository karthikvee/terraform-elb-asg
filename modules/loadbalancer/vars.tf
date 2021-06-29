variable "region" {
  type        = string
  description = "Set Provide Region"
  default     = "us-east-1"
}

variable "loadbalancer_type" {
  type        = string
  description = "Load Balancer Type"
  default     = "application"
}

variable "loadbalancer_name" {
  type        = string
  description = "loadbalancer name"
  default     = "lb-web"
}

variable "public_subnet" {
  description = "public subnets"
}

variable "instace_web_id" {
  type        = string
  default     = "instance ids to add lb"
}
variable "sg_ids" {
  type        = string
  description = "security group id"
}

variable "loadbalancer_targetgroup_name" {
  type        = string
  description = "LB Target Group Name"
  default     = "lb-tg-web"
}

variable "loadbalancer_port" {
  type        = number
  description = "Load Balancer port to check instances"
  default     = 80
}

variable "loadbalancer_protocol" {
  type        = string
  description = "Load Balancer protocol to check instances"
  default     = "HTTP"
}

variable "lb_action_type" {
  type        = string
  description = "LB - Default Action type"
  default     = "forward"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}
