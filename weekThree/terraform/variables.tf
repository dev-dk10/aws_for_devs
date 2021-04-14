variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type = string
  default = "AppServerInstance3"
}

variable "AWS_REGION" {
  description = "AWS region"
  type = string
  default = "us-west-2"
}

variable "es2_ami_id" {
  description = "AMI identifier for ES2 instance"
  type = string
  default = "ami-0518bb0e75d3619ca"
}

variable "es2_instance_type" {
  description = "ES2 instance type"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "EC2 instance ssh key"
  type = string
  default = "KeyExample"
}