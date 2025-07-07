provider "aws" {
  region = var.region
}

resource "aws_security_group" "app_sg" {
  name = "app_sg"

  ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
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
    }
  ]
  egress = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

resource "aws_instance" "flask" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.app_sg.name]
  user_data     = file("userdata_flask.sh")

  tags = {
    Name = "FlaskInstance"
  }
}

resource "aws_instance" "express" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.app_sg.name]
  user_data     = file("userdata_express.sh")

  tags = {
    Name = "ExpressInstance"
  }
}
