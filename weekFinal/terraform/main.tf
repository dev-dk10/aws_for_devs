# Public

resource "aws_instance" "edu-lohika-training-aws-nat-instance" {
  ami = var.es2_nat_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  security_groups = [aws_security_group.edu-lohika-training-public-security_group.id]
  subnet_id = aws_subnet.edu-lohika-training-aws-public-subnet.id
  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    Name = "NAT Instance"
  }
}

resource "aws_dynamodb_table" "edu-lohika-training-aws-dynamodb" {
  name = "edu-lohika-training-aws-dynamodb"
  read_capacity = 10
  write_capacity = 10
  hash_key = "UserName"
  
  attribute {
    name = "UserName"
    type = "S"
  }
}

resource "aws_launch_configuration" "edu-lohika-training-public-launch-template" {
  image_id = var.es2_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  iam_instance_profile = aws_iam_instance_profile.edu-lohika-training-aws-instance-profile.name
  security_groups = [aws_security_group.edu-lohika-training-public-security_group.id]
  user_data = <<-EOF
    #!/bin/bash
    sudo yum install java-1.8.0-openjdk -y
    aws s3 cp s3://dkushnirov-s3-week3/calc-2021-0.0.2-SNAPSHOT.jar /calc-2021-0.0.2-SNAPSHOT.jar
    java -jar calc-2021-0.0.2-SNAPSHOT.jar
  EOF
}

resource "aws_autoscaling_group" "edu-lohika-training-aws-asg-appserver-frontend-cluster" {
  max_size = 3
  min_size = 2
  vpc_zone_identifier = [aws_subnet.edu-lohika-training-aws-public-subnet.id]
  launch_configuration = aws_launch_configuration.edu-lohika-training-public-launch-template.name
  load_balancers= [aws_elb.edu-lohika-training-aws-load-balancer.id]
 }


 # Private

 resource "aws_db_subnet_group" "edu-lohika-training-aws-db-subnet-group" {
  name = "edu-lohika-training-aws-db-subnet-group"
  subnet_ids = [aws_subnet.edu-lohika-training-aws-public-subnet.id, aws_subnet.edu-lohika-training-aws-private-subnet.id]
}


resource "aws_db_instance" "edu-lohika-training-aws-db-instance" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "postgres"
  engine_version = "11.5"
  identifier = "edu-lohika-training-aws-rds"
  instance_class = "db.t2.micro"
  name = "EduLohikaTrainingAwsRds"
  port = 5432
  publicly_accessible = true
  skip_final_snapshot = true
  iam_database_authentication_enabled = true
  username = "rootuser"
  password = "rootuser"
  vpc_security_group_ids = [aws_security_group.edu-lohika-training-public-security_group.id]
  db_subnet_group_name = aws_db_subnet_group.edu-lohika-training-aws-db-subnet-group.name
}

resource "aws_instance" "edu-lohika-training-aws-private-instance" {
  ami = var.es2_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  iam_instance_profile = aws_iam_instance_profile.edu-lohika-training-aws-instance-profile.name
  vpc_security_group_ids = [aws_security_group.edu-lohika-training-private-security_group.id]
  subnet_id = aws_subnet.edu-lohika-training-aws-private-subnet.id
  user_data = <<-EOF
    #!/bin/bash
    sudo yum install java-1.8.0-openjdk -y
    aws s3 cp s3://dkushnirov-s3-week3/persist3-2021-0.0.1-SNAPSHOT.jar  /persist3-2021-0.0.1-SNAPSHOT.jar 
    export RDS_HOST=${aws_db_instance.edu-lohika-training-aws-db-instance.address}
    echo "RDS_HOST=${aws_db_instance.edu-lohika-training-aws-db-instance.address}" >> /etc/environment
    java -jar persist3-2021-0.0.1-SNAPSHOT.jar 
  EOF
}