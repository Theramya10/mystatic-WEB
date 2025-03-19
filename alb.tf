resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets           = [aws_subnet.public_subnet.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol         = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.asg_tg.arn
  }
}

resource "aws_lb_target_group" "asg_tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}
