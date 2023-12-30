variable "region" {
  description = "region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = "web-server-vpc"
}

variable "vpc_cidr" {
  description = "Cidr block"
  type        = string
  default     = "11.0.0.0/16"
}
variable "azs" {
  description = "avalibily Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "public_subnets" {
  description = "public_subnets"
  type        = list(string)
  default     = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24", "11.0.4.0/24"]
}
variable "private_subnets" {
  description = "private subnets"
  type        = list(string)
  default     = ["11.0.5.0/24", "11.0.6.0/24", "11.0.7.0/24", "11.0.8.0/24"]
}
variable "enable_nat_gateway" {
  description = "enable nat gateway"
  type        = bool
  default     = true
}
variable "enable_vpn_gateway" {
  description = "enable vpn gateway"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "instance_type"
  type        = string
  default     = "t2.medium"
}
variable "key_name" {
  description = "keypair"
  type        = string
  default     = "terraformroom"
}