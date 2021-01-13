#########################
# SecurityGroupRule RDS #
#########################
resource "aws_security_group_rule" "gadget-rds-sg-rule1" {
  description       = "gadget rds sg rule"
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", "0.0.0.0/16"]
  security_group_id = aws_security_group.gadget-rds-sg.id
}
resource "aws_security_group_rule" "gadget-rds-sg-rule2" {
  description       = "gadget rds sg rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-rds-sg.id
}
resource "aws_security_group_rule" "gadget-rds-sg-rule3" {
  description       = "gadget rds sg rule3"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.gadget-rds-sg.id
}


#########################
# SecurityGroupRule ALB #
#########################
resource "aws_security_group_rule" "gadget-alb-sg-rule1" {
  description       = "gadget-alb-sg-rule1"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-alb-sg.id
}
resource "aws_security_group_rule" "gadget-alb-sg-rule2" {
  description       = "gadget-alb-sg-rule2"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-alb-sg.id
}
resource "aws_security_group_rule" "gadget-alb-sg-rule3" {
  description       = "gadget-alb-sg-rule3"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-alb-sg.id
}
resource "aws_security_group_rule" "gadget-alb-sg-rule4" {
  description       = "gadget-alb-sg-rule4"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-alb-sg.id
}
resource "aws_security_group_rule" "gadget-alb-sg-rule5" {
  description       = "gadget-alb-sg-rule5"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-alb-sg.id
}
resource "aws_security_group_rule" "gadget-alb-sg-rule6" {
  description       = "gadget-alb-sg-rule6"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-alb-sg.id
}

#########################
# SecurityGroupRule ECS #
#########################
resource "aws_security_group_rule" "gadget-ecs-sg-rule1" {
  description       = "gadget-ecs-sg-rule1"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-ecs-sg.id
}
resource "aws_security_group_rule" "gadget-ecs-sg-rule2" {
  description       = "gadget-ecs-sg-rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-ecs-sg.id
}
resource "aws_security_group_rule" "gadget-ecs-sg-rule3" {
  description       = "gadget-ecs-sg-rule3"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-ecs-sg.id
}
resource "aws_security_group_rule" "gadget-ecs-sg-rule4" {
  description       = "gadget-ecs-sg-rule4"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-ecs-sg.id
}
resource "aws_security_group_rule" "gadget-ecs-sg-rule5" {
  description              = "gadget-ecs-sg-rule5"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.gadget-alb-sg.id
  security_group_id        = aws_security_group.gadget-ecs-sg.id
}
resource "aws_security_group_rule" "gadget-ecs-sg-rule6" {
  description       = "gadget-ecs-sg-rule6"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-ecs-sg.id
}
resource "aws_security_group_rule" "gadget-ecs-sg-rule7" {
  description       = "gadget-ecs-sg-rule5"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gadget-ecs-sg.id
}
