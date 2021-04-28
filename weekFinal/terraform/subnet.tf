resource "aws_subnet" "edu-lohika-training-aws-public-subnet" {
  vpc_id = aws_vpc.edu-lohika-training-aws-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "edu-lohika-training-aws-private-subnet" {
  vpc_id = aws_vpc.edu-lohika-training-aws-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
}