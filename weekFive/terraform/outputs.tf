
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value = aws_instance.EC2InstanceForSNS.public_ip
}

output "sns_topic_arn" {
  description = "Newly created SNS topic ARN"
  value = aws_sns_topic.sns_topic.arn
}

output "sqs_queue_url" {
  description = "Newly created SQS queue URL"
  value = aws_sqs_queue.sqs_queue.id
}
