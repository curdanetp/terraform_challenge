# SUBNETTING --------------------------------------------------------
# LOAD BALANCERS SUBNETS

resource "aws_subnet" "lbl_pub_snet_1" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}a"
  cidr_block        = "${var.vpc_cidr_prefix}0.0/24"
  map_public_ip_on_launch = "true"
  tags              = { "Name" = "lbl_pub_snet_1" }
}
resource "aws_subnet" "lbl_pub_snet_2" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}b"
  cidr_block        = "${var.vpc_cidr_prefix}1.0/24"
  map_public_ip_on_launch = "true"
  tags              = { "Name" = "lbl_pub_snet_2" }
}

# APP INSTANCES SUBNETS
resource "aws_subnet" "app_prv_snet_1" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}a"
  cidr_block        = "${var.vpc_cidr_prefix}2.0/24"
  tags              = { "Name" = "app_prv_snet_1" }
}
resource "aws_subnet" "app_prv_snet_2" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}b"
  cidr_block        = "${var.vpc_cidr_prefix}3.0/24"
  tags              = { "Name" = "lbl_pub_snet_2" }
}
resource "aws_subnet" "app_prv_snet_3" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}c"
  cidr_block        = "${var.vpc_cidr_prefix}4.0/24"
  tags              = { "Name" = "lbl_pub_snet_2" }
}

# BKE INSTANCES SUBNETS
resource "aws_subnet" "bke_prv_snet_1" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}a"
  cidr_block        = "${var.vpc_cidr_prefix}5.0/24"
  tags              = { "Name" = "bke_prv_snet_1" }
}
resource "aws_subnet" "bke_prv_snet_2" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}b"
  cidr_block        = "${var.vpc_cidr_prefix}6.0/24"
  tags              = { "Name" = "bke_prv_snet_2" }
}
resource "aws_subnet" "bke_prv_snet_3" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}c"
  cidr_block        = "${var.vpc_cidr_prefix}7.0/24"
  tags              = { "Name" = "bke_prv_snet_3" }
}
resource "aws_subnet" "rds_prv_snet_1" {
  vpc_id            = aws_vpc.tfc_vpc.id
  availability_zone = "${var.AWS_REGION}a"
  cidr_block        = "${var.vpc_cidr_prefix}8.0/24"
  tags              = { "Name" = "rds_prv_snet_1" }
}

