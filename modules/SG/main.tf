resource "aws_security_group" "asg_sg" {
  name        = var.asg-sg-name
  description = "Allow HTTP access"
  vpc_id      = var.vpc-id

  ingress {
    description = "Allow 443 from host machine"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}