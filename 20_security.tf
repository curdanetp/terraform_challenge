# Configuration related to security groups
# Public S.Group
resource "aws_security_group" "tfc-pub-sg" {
  name        = "tfc-pub-sg"
  description = "Security Group Public"
  vpc_id      = aws_vpc.tfc_vpc.id
  ingress {
    description = "SSH Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# App Load Balancer S.Group
resource "aws_security_group" "tfc_app_lb_sg" {
  name        = "tfc_app_lb_sg"
  description = "Security Group for Apps Load Balancer"
  vpc_id      = aws_vpc.tfc_vpc.id
  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# App S.Group
resource "aws_security_group" "tfc_app_sg" {
  name        = "tfc_app_sg"
  description = "Security Group for Apps Instances"
  vpc_id      = aws_vpc.tfc_vpc.id

  ingress {
    description = "SSH Internally"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    description = "Port 80 from APP-ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
      "${aws_security_group.tfc_app_lb_sg.id}",
    ]
  }

}
# Bkend Load Balancer S.Group
resource "aws_security_group" "tfc_bke_lb_sg" {
  name        = "tfc_bke_lb_sg"
  description = "Security Group from Apps Instances to Bke LoadBalancer"
  vpc_id      = aws_vpc.tfc_vpc.id

  ingress {
    description = "Port 4000"
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Bkend S.Group
resource "aws_security_group" "tfc_bke_sg" {
  name        = "tfc_bke_sg"
  description = "Security Group for Backend Instances"
  vpc_id      = aws_vpc.tfc_vpc.id

  ingress {
    description = "SSH Internally"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    description = "Port 4000 from APP-ALB"
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    security_groups = [
      "${aws_security_group.tfc_bke_lb_sg.id}",
    ]
  }

}
# RDS Database Server S.Group
resource "aws_security_group" "tfc_rds_dba_sg" {
  name        = "tfc_rds_dba_sg"
  description = "Security Group for RDS Database"
  vpc_id      = aws_vpc.tfc_vpc.id

  ingress {
    description = "Port 5432 Postgresql"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.tfc_bke_sg.id]
  }

}
