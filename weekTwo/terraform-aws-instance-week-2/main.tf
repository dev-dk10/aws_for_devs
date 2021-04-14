resource "aws_instance" "app_server" {
  ami = var.es2_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.RootInstanceProfile.name
  vpc_security_group_ids = [
    aws_security_group.web-sg.id,
    aws_security_group.ssh-sg.id,
  ]
  user_data = file("init-script.sh")
  tags = {
    Name = var.instance_name
  }
}

resource "aws_iam_role" "S3WritableRole" {
  name = "S3WritableRole"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "InstancePolicy" {
  name = "InstancePolicy"
  role = aws_iam_role.S3WritableRole.id

  policy = jsonencode({
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "s3:CreateBucket",
          "s3:ListBucket",
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "RootInstanceProfile" {
  name = "RootInstanceProfile"
  role = aws_iam_role.S3WritableRole.name
}
