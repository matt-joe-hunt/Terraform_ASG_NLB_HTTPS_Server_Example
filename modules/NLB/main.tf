resource "aws_lb" "nlb" {
  name               = "nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public-subnet-ids

  tags = {
    Environment = terraform.workspace
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nlb.arn
  protocol = "TCP"
  port              = "443"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "nlb-tg"
  port     = 443
  protocol = "TCP"
  vpc_id   = var.vpc-id
}