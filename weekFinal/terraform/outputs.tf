output "sns_topic_arn" {
  description = "Newly created SNS topic ARN"
  value = aws_sns_topic.edu-lohika-training-aws-sns-topic.arn
}

output "sqs_queue_url" {
  description = "Newly created SQS queue URL"
  value = aws_sqs_queue.edu-lohika-training-aws-sqs-queue.id
}
