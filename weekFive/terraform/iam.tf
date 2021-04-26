resource "aws_iam_instance_profile" "es2_profile" {
  name = "es2_profile"
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_role" "iam_role" {
  name = "iam_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "sqs_sns_policy" {
  name = "sqs_sns_policy"
  role = aws_iam_role.iam_role.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sqs:*",
        Effect = "Allow",
        Resource = "*"
      },
      {
        Action = "sns:*",
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}
