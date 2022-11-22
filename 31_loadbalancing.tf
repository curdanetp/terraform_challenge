# APP Target Group
resource "aws_lb_target_group" "tfc_app_tgt_grp" {
  name     = "tfc_app_tgt_grp"
  target_type = "alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tfc_vpc.id
}

# Backend Target Group
resource "aws_lb_target_group" "tfc_bke_tgt_grp" {
  name     = "tfc_bke_tgt_grp"
  target_type = "alb"
  port     = 4000
  protocol = "TCP"
  vpc_id   = aws_vpc.tfc_vpc.id
}