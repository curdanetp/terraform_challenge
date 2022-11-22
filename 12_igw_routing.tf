# Internet Gateway
resource "aws_internet_gateway" "tfc_igw" {
  vpc_id = aws_vpc.tfc_vpc.id
  tags = {
    Name = "Challenge Internet Gateway"
  }
}
# PUBLIC ROUTES (IGW - ALBS) ------------------------------------------------------------------------------------------
# Route table: Internet Gateway #######################################################################################
resource "aws_route_table" "tfc_pub_rt_table" {
  vpc_id = aws_vpc.tfc_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfc_igw.id
  }
}

# Adding Default Public Route to Table
resource "aws_route" "default_pub_route" {
  route_table_id         = aws_route_table.tfc_pub_rt_table.id
  destination_cidr_block = var.default_route
  gateway_id             = aws_internet_gateway.tfc_igw.id
}

# Route table association of public subnets
# App ALB Route Table
resource "aws_route_table_association" "tfc_pub_app_rt" {
  subnet_id      = aws_subnet.lbl_pub_snet_1.id
  route_table_id = aws_route_table.tfc_pub_rt_table.id
}
# BackEnd ALB Route Table
resource "aws_route_table_association" "tfc_pub_bke_rt" {
  subnet_id      = aws_subnet.lbl_pub_snet_2.id
  route_table_id = aws_route_table.tfc_pub_rt_table.id
}

# PRIVATE APP ROUTES ------------------------------------------------------------------------------------------
# Route table: APPLICATION ROUTE TABLE ########################################################################
resource "aws_route_table" "tfc_app_rt_table" {
  vpc_id = aws_vpc.tfc_vpc.id
  route {
    cidr_block = "${var.vpc_cidr_prefix}0.0/16"    
    gateway_id = aws_internet_gateway.tfc_igw.id
  }
}

# Route table association of public subnets
# App ALB Route Table
resource "aws_route_table_association" "tfc_prv_app_a_rt" {
  subnet_id      = aws_subnet.app_prv_snet_1.id
  route_table_id = aws_route_table.tfc_app_rt_table.id
}
resource "aws_route_table_association" "tfc_prv_app_b_rt" {
  subnet_id      = aws_subnet.app_prv_snet_2.id
  route_table_id = aws_route_table.tfc_app_rt_table.id
}
resource "aws_route_table_association" "tfc_prv_app_c_rt" {
  subnet_id      = aws_subnet.app_prv_snet_3.id
  route_table_id = aws_route_table.tfc_app_rt_table.id
}
# Route table: BACKEND ROUTE TABLE ########################################################################
resource "aws_route_table" "tfc_bke_rt_table" {
  vpc_id = aws_vpc.tfc_vpc.id
  route {
    cidr_block = "${var.vpc_cidr_prefix}0.0/16"
    gateway_id = aws_internet_gateway.tfc_igw.id
  }
}

# Route table association of public subnets
# App ALB Route Table
resource "aws_route_table_association" "tfc_prv_bke_a_rt" {
  subnet_id      = aws_subnet.bke_prv_snet_1.id
  route_table_id = aws_route_table.tfc_bke_rt_table.id
}
resource "aws_route_table_association" "tfc_prv_bke_b_rt" {
  subnet_id      = aws_subnet.bke_prv_snet_2.id
  route_table_id = aws_route_table.tfc_bke_rt_table.id
}
resource "aws_route_table_association" "tfc_prv_bke_c_rt" {
  subnet_id      = aws_subnet.bke_prv_snet_3.id
  route_table_id = aws_route_table.tfc_bke_rt_table.id
}



