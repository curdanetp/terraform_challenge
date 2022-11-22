# Setup AWS Region
variable "AWS_REGION" {
  default = "us-east-1" //N.Virginia
}

# Setup VPC CIDR Prefix
variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

# Setup CIDR Prefix in Use 
variable "vpc_cidr_prefix" {
  default = "10.1."
}

# Setup Availability Zones 
variable "av_zones" {
  default = ["a","b","c"]
}

# Setup Default Route
variable "default_route" {
  type        = string
  description = "Default Route from and to internet"
  default     = "0.0.0.0/0"
}