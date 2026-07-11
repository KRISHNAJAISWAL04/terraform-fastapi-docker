resource "aws_instance" "my_instance"{
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair

  vpc_security_group_ids = [
    aws_security_group.my_security.id
  ]

  user_data = file("userdata.sh")

  tags = {
    Name = "fast-api"
  }
}

      


resource "aws_security_group" "my_security"{
    name        = "fast-api"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "Terraform-Nginx-SG"
  }

}





