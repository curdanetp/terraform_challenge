# Frontend Section ############################################################
# APPLICATION LAUNCH TEMPLATE
resource "aws_launch_template" "tfc_app_ltplt" {
  name                                 = "tfc_app_ltplt"
  image_id                             = var.tfc_app_ami
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.TFC_INSTANCE_TYPE
  vpc_security_group_ids               = ["${aws_security_group.tfc_app_sg.id}"]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "tfc_app_instance"
    }
  }
  user_data = base64encode("${var.tfc_app_launch_script}")
}


# APPLICATION LOAD BALANCER ALB FRONTEND
resource "aws_autoscaling_group" "tfc_app_asg" {
  name                      = "tfc_app_asg"
  max_size                  = 4
  min_size                  = 3
  desired_capacity          = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = "true"
  launch_template {
    id      = aws_launch_template.tfc_app_ltplt.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.app_prv_snet_1.id, aws_subnet.app_prv_snet_2.id, aws_subnet.app_prv_snet_3.id]
  target_group_arns   = [aws_lb_target_group.tfc_app_tgt_grp.arn]
}

# Backend Section ############################################################
# BACKEND APLICATION LAUNCH TEMPLATE
resource "aws_launch_template" "tfc_bke_ltplt" {
  name                                 = "tfc_bke_ltplt"
  image_id                             = var.tfc_bke_ami
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.TFC_INSTANCE_TYPE
  vpc_security_group_ids               = ["${aws_security_group.tfc_bke_sg.id}"]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "tfc_bke_instance"
    }
  }
  user_data = base64encode("${var.tfc_bke_launch_script}")
}


# APPLICATION LOAD BALANCER ALB FRONTEND
resource "aws_autoscaling_group" "tfc_bke_asg" {
  name                      = "tfc_bke_asg"
  max_size                  = 4
  min_size                  = 3
  desired_capacity          = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = "true"
  launch_template {
    id      = aws_launch_template.tfc_bke_ltplt.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.bke_prv_snet_1.id, aws_subnet.bke_prv_snet_2.id, aws_subnet.bke_prv_snet_3.id]
  target_group_arns   = [aws_lb_target_group.tfc_bke_tgt_grp.arn]
}
