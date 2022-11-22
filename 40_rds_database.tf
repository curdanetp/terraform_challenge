resource "aws_db_instance" "tfc_rds_pg" {
  identifier             = "tfc-rd-spg"  
  instance_class         = "db.t2.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "12.5"
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_name = "tasks"
  vpc_security_group_ids = [aws_security_group.tfc_bke_sg.id]
  username               = "postgres"
  password               = "${var.db_password}"
}