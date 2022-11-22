resource "aws_vpc" "tfc_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "tfc_vpc"
  }
}