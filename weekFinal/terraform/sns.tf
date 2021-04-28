resource "aws_sqs_queue" "edu-lohika-training-aws-sqs-queue" {
  name = "edu-lohika-training-aws-sqs-queue"
  
  tags = {
     Name = "SQS Queue"
  }
}

resource "aws_sns_topic" "edu-lohika-training-aws-sns-topic" {
  name = "edu-lohika-training-aws-sns-topic"

  tags = {
    Name = "SNS Topic"
  }
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.edu-lohika-training-aws-sns-topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.edu-lohika-training-aws-sqs-queue.arn
}
