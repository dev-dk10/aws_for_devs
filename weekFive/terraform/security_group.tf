resource "aws_security_group" "ssh_security_group" {
  name = "ssh_security_group"

  description = "Allow ssh access"

  ingress {
    description = "Enable HTTP access via port 22"
    from_port = 22
    to_port = 22
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
    Name = "Allow SSH"
  }
}
