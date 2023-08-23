resource "aws_lb" "load_balancer" {
  name               = "load-balancer"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
}

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
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

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.acm_certificate.id

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_branch_tg.arn
  }
}


resource "aws_lb_target_group" "develop_branch_tg" {
  name     = "develop-branch-app"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    enabled             = true
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group" "main_branch_tg" {
  name     = "main-branch-app"
  port     = 5001
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    enabled             = true
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "main_branch_to_instance_1a" {
  target_group_arn = aws_lb_target_group.main_branch_tg.arn
  target_id        = aws_instance.ecs_instance_1a.id
  port             = 5001
}

resource "aws_lb_target_group_attachment" "develop_branch_to_instance_1a" {
  target_group_arn = aws_lb_target_group.develop_branch_tg.arn
  target_id        = aws_instance.ecs_instance_1a.id
  port             = 5000
}


resource "aws_lb_listener_rule" "main_branch_rule" {
  listener_arn = aws_lb_listener.alb_https_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_branch_tg.arn
  }

  condition {
    host_header {
      values = ["${var.registered_domain}"]
    }
  }
}

resource "aws_lb_listener_rule" "dev_branch_rule" {
  listener_arn = aws_lb_listener.alb_https_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.develop_branch_tg.arn
  }

  condition {
    host_header {
      values = ["dev.${var.registered_domain}"]
    }
  }
}



# resource "aws_lb_listener" "http_listener" {
#   load_balancer_arn = aws_lb.load_balancer.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "redirect"
#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

# resource "aws_lb_listener" "https_listener" {
#   load_balancer_arn = aws_lb.load_balancer.arn
#   port              = 443
#   protocol          = "HTTPS"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.main_branch_app.arn
#   }
# }