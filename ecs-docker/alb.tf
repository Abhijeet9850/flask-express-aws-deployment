resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  security_groups    = [aws_security_group.lb_sg.id]
}

# Create target groups and listeners to route requests to ECS services based on path (/api -> Flask, / -> Express)
