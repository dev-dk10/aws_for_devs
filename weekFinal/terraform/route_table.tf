resource "aws_internet_gateway" "edu-lohika-training-aws-vpc-gateway" {
  vpc_id = aws_vpc.edu-lohika-training-aws-vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_default_route_table" "edu-lohika-training-aws-default-route-table" {
  default_route_table_id = aws_vpc.edu-lohika-training-aws-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.edu-lohika-training-aws-nat-instance.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table" "edu-lohika-training-aws-main-route-table" {
  vpc_id = aws_vpc.edu-lohika-training-aws-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.edu-lohika-training-aws-vpc-gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "edu-lohika-training-aws-route-table-association" {
  subnet_id = aws_subnet.edu-lohika-training-aws-public-subnet.id
  route_table_id = aws_route_table.edu-lohika-training-aws-main-route-table.id
}
