resource "aws_security_group" "public_security_group" {
  name = "public_security_group"
  vpc_id = aws_vpc.my_vpc.id

  description = "Allow ssh, http access"

  ingress {
    description = "inbound ssh traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "inbound http traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow SSH, HTTP"
  }
}

resource "aws_security_group" "private_security_group" {
  name = "private_security_group"
  vpc_id = aws_vpc.my_vpc.id

  description = "Allow ssh access"

  ingress {
    description = "inbound ssh traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
  ingress {
    description = "inbound http traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
  ingress {
    description = "inbound ping traffic"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["10.0.1.0/24"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow SSH"
  }
}