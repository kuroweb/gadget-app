#########
#  ALB  #
#########
resource "aws_lb" "gadget-alb" {
  name                       = "gadget-alb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = [
    aws_subnet.gadget-public-1a.id,
    aws_subnet.gadget-public-1c.id
  ]

  security_groups = [
    aws_security_group.gadget-alb-sg.id
  ]

  tags = {
    Name = "gadget-alb"
  }
}

############
# Listener #
############
resource "aws_lb_listener" "gadget-http-listener" {
  load_balancer_arn = aws_lb.gadget-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener" "gadget-https-listener" {
  load_balancer_arn = aws_lb.gadget-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.gadget-acm.arn

  default_action {
    target_group_arn = aws_lb_target_group.gadget-alb-front-tg.arn
    type             = "forward"
  }
}
resource "aws_lb_listener" "gadget-api-listener" {
  load_balancer_arn = aws_lb.gadget-alb.arn
  port              = "3000"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.gadget-acm.arn

  default_action {
    target_group_arn = aws_lb_target_group.gadget-alb-api-tg.arn
    type             = "forward"
  }
}

###############
# TargetGroup #
###############
resource "aws_lb_target_group" "gadget-alb-front-tg" {
  name        = "gadget-alb-front-tg"
  target_type = "ip"
  vpc_id      = aws_vpc.gadget-vpc.id
  port        = 80
  protocol    = "HTTP"

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 120
    interval            = 150
    matcher             = 200
    port                = 80
    protocol            = "HTTP"
  }
}
resource "aws_lb_target_group" "gadget-alb-api-tg" {
  name        = "gadget-alb-api-tg"
  target_type = "ip"
  vpc_id      = aws_vpc.gadget-vpc.id
  port        = 3000
  protocol    = "HTTP"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/v1/tasks"
    port                = 3000
    protocol            = "HTTP"
    matcher             = 200
    timeout             = 50
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}