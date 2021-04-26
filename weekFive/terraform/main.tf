resource "aws_instance" "EC2InstanceForSNS" {
  ami = var.es2_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh_security_group.id]
  iam_instance_profile = aws_iam_instance_profile.es2_profile.name

  tags = {
    Name = "EC2InstanceForSNS"
  }
}

resource "aws_sns_topic" "sns_topic" {
  name = "sns_topic"

  tags = {
    Name = "SNS Topic"
  }
}

resource "aws_sqs_queue" "sqs_queue" {
  name = "sqs_queue"

  tags = {
    Name = "SQS Queue"
  }
}