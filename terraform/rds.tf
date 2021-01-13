#########
#  RDS  #
#########
resource "aws_db_instance" "gadget-db" {
  allocated_storage = 20
  instance_class    = "db.t3.micro"
  engine            = "postgres"
  engine_version    = "12.3"
  storage_type      = "gp2"
  username                = var.DB_USERNAME
  password                = var.DB_PASSWORD
  backup_retention_period = 7
  copy_tags_to_snapshot   = true
  max_allocated_storage   = 200
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.gadget-rds-sg.id]
  db_subnet_group_name    = aws_db_subnet_group.gadget-rds-subnet-group.name
  # enabled_cloudwatch_logs_exports = [
  #   "audit",
  #   "error",
  #   "general",
  #   "slowquery",
  # ]

  lifecycle {
    prevent_destroy = false
  }

}
