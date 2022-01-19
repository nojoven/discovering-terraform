resource "aws_lb" "nginx-alb" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-00ac967863d608b4f"]
  subnets            = ["subnet-09295117ef889629f", "subnet-0a79828d3a728148e"]

  enable_deletion_protection = false

  tags = {
    Name = "Nginx-alb"
  }
}

resource "aws_lb_target_group" "nginx-alb" {
  name     = "nginx-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0f34b0c824b62fc1c"
}

resource "aws_lb_listener" "nginx-alb" {
  load_balancer_arn = aws_lb.nginx-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-alb.arn
  }
}
