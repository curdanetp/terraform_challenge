# VPC Definition 
resource "aws_vpc" "tfc_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  tags = {
    "Name" = "tfc_vpc"
  }
}