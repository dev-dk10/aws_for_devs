output "dns_name" {
  description = "Public IP address of the EC2 instance"
  value = aws_lb.load_balancer.dns_name
}