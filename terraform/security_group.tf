#####################
# SecurityGroup RDS #
#####################
resource "aws_security_group" "gadget-rds-sg" {
  description = "RDS security group for gadget"
  name        = "gadget-rds-sg"
  vpc_id      = aws_vpc.gadget-vpc.id
}

#####################
# SecurityGroup ALB #
#####################
resource "aws_security_group" "gadget-alb-sg" {
  name        = "gadget-alb-sg"
  description = "ALB security group for gadget"
  vpc_id      = aws_vpc.gadget-vpc.id
}

#####################
# SecurityGroup ECS #
#####################
resource "aws_security_group" "gadget-ecs-sg" {
  vpc_id      = aws_vpc.gadget-vpc.id
  name        = "gadget-ecs-sg"
  description = "ECS service security group for gadget"
}
