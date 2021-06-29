variable "region" {
  type        = string
  description = "Set Provide Region"
  default     = "us-east-1"
}

variable "s3_role_name" {
  type        = string
  description = "S3 Access role name"
  default     = "s3-access-role"
}

variable "s3_role_file_path" {
  type        = string
  description = "S3 Role file path (e.g /path/role.json)"
  default     = "../../files/s3_role.json"
}

variable "s3_policy_name" {
  type        = string
  description = "S3 Access Policy name"
  default     = "s3-access-policy"
}

variable "s3_policy_file_path" {
  type        = string
  description = "S3 Policy file path (e.g /path/policy.json)"
  default     = "../../files/s3_policy.json"
}


