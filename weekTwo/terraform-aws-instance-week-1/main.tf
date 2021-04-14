resource "aws_launch_template" "launch_template" {
  image_id = var.es2_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  vpc_security_group_ids = [
    aws_security_group.web-sg.id,
    aws_security_group.ssh-sg.id,
  ]
  user_data = filebase64("${path.module}/init-script.sh")
}

resource "aws_autoscaling_group" "autoscaling_group" {
  max_size = 2
  min_size = 2
  availability_zones = ["us-west-2a"]

  launch_template {
    id = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}
