resource "aws_security_group" "edu-lohika-training-public-security_group" {
  name = "edu-lohika-training-public-security_group"
  description = "Allow ssh and http for public"
  vpc_id = aws_vpc.edu-lohika-training-aws-vpc.id

  ingress {
    protocol = "tcp"
    to_port = 22
    from_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    to_port = 80
    from_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "-1"
    to_port = 0
    from_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "edu-lohika-training-private-security_group" {
  name = "edu-lohika-training-private-security_group"
  description = "Allow ssh, http and postgress for private"
  vpc_id = aws_vpc.edu-lohika-training-aws-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
