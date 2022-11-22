# TARGET GROUPS ####################################################
# APP Target Group
resource "aws_lb_target_group" "tfc_app_tgt_grp" {
  name        = "tfc-app-tgt-grp"
  target_type = "instance"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.tfc_vpc.id
}

# Backend Target Group
resource "aws_lb_target_group" "tfc_bke_tgt_grp" {
  name        = "tfc-bke-tgt-grp"
  target_type = "instance"
  port        = 4000
  protocol    = "TCP"
  vpc_id      = aws_vpc.tfc_vpc.id
}

# LOAD BALANCERS ####################################################
# APP LB
resource "aws_lb" "tfc_app_alb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tfc_app_lb_sg.id]
  subnets            = [aws_subnet.app_prv_snet_1.id, aws_subnet.app_prv_snet_2.id, aws_subnet.app_prv_snet_3.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production",
    name        = "tfc_app_alb"
  }
}

resource "aws_lb_listener" "tfc_app_alb_listen" {
  load_balancer_arn = aws_lb.tfc_app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tfc_app_tgt_grp.arn
  }
}

# BKE LB
resource "aws_lb" "tfc_bke_alb" {
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tfc_bke_lb_sg.id]
  subnets            = [aws_subnet.bke_prv_snet_1.id, aws_subnet.bke_prv_snet_2.id, aws_subnet.bke_prv_snet_3.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production",
    name        = "tfc_bke_alb"
  }
}

resource "aws_lb_listener" "tfc_bke_alb_listen" {
  load_balancer_arn = aws_lb.tfc_bke_alb.arn
  port              = "4000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tfc_bke_tgt_grp.arn
  }
}