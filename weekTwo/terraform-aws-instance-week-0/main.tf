resource "aws_instance" "app_server" {
  ami = var.es2_ami_id
  instance_type = var.es2_instance_type
  key_name = var.key_name
  user_data = file("init-script.sh")
  vpc_security_group_ids = [
    aws_security_group.web-sg.id,
    aws_security_group.ssh-sg.id,
  ]

  tags = {
    Name = var.instance_name
  }
}