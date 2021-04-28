resource "aws_iam_role" "edu-lohika-training-aws-role" {
  name = "edu-lohika-training-aws-role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "edu-lohika-training-access-policies" {
  name = "access_policies"
  role = aws_iam_role.edu-lohika-training-aws-role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": ["s3:GetObject"],
        "Resource": "*"
      },
      {
            "Effect": "Allow",
            "Action": "rds:*",
            "Resource": ["arn:aws:rds:us-west-2:*:*"]
      },
      {
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": ["arn:aws:dynamodb:us-west-2:*:*"]
      },
      {
            "Effect": "Allow",
            "Action": "sns:*",
            "Resource": "*"
      },
      {
      		"Effect": "Allow",
            "Action": "sqs:*",
            "Resource": "*"
      }



    ]
  }
  EOF
}

resource "aws_iam_instance_profile" "edu-lohika-training-aws-instance-profile" {
  name = "InstanceProfile"
  role = aws_iam_role.edu-lohika-training-aws-role.name
}
