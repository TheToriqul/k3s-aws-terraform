output "instance_id" {
  value = aws_instance.k3s.id
}

output "private_ip" {
  value = aws_instance.k3s.private_ip
}