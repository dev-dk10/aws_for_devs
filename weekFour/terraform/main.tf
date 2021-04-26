resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Week-VPC-5"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.NatInstance.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id

  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my_vpc.id

  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_instance" "MyEC2InstancePublic" {
  ami = var.es2_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  security_groups  = [aws_security_group.public_security_group.id]
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "Public Instance"
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo yum -y install httpd
                sudo service httpd start
                chkconfig httpd on
                echo "<html><h1>This is WebServer from public subnet</h1></html>" > /var/www/html/index.html
                EOF
}

resource "aws_instance" "MyEC2InstancePrivate" {
  ami = var.es2_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  security_groups  = [aws_security_group.private_security_group.id]
  subnet_id = aws_subnet.private_subnet.id

  tags = {
    Name = "Private Instance"
  }

  depends_on = [
    aws_instance.NatInstance
  ]

  user_data = <<-EOF
                #!/bin/bash
                sudo yum -y install httpd
                sudo service httpd start
                chkconfig httpd on
                echo "<html><h1>This is WebServer from private subnet</h1></html>" > /var/www/html/index.html
                EOF
}

resource "aws_instance" "NatInstance" {
  ami = "ami-0032ea5ae08aa27a2"
  instance_type = var.es2_instance_type
  key_name = var.key_name
  security_groups  = [aws_security_group.public_security_group.id]
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    Name = "NAT Instance"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name = "lb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    path = "/index.html"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "public_attachment" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id = aws_instance.MyEC2InstancePublic.id
}

resource "aws_lb_target_group_attachment" "private_attachment" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id = aws_instance.MyEC2InstancePrivate.id
}

resource "aws_lb" "load_balancer" {
  name = "load-balancer"
  load_balancer_type = "application"
  internal = false
  security_groups = [aws_security_group.public_security_group.id]
  subnets = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

  tags = {
    Name = "Application Load Balancer"
  }
}

resource "aws_lb_listener" "front" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}