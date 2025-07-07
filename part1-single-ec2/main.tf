provider "aws" {
  region = var.region
}

resource "aws_instance" "flask_express" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data              = file("userdata.sh")

  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "FlaskExpressInstance"
  }
}

resource "aws_security_group" "sg" {
  name        = "flask_express_sg"
  description = "Allow Flask and Express traffic"
  ingress = [
    {
      from_port   = var.app_port_flask
      to_port     = var.app_port_flask
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = var.app_port_express
      to_port     = var.app_port_express
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}
