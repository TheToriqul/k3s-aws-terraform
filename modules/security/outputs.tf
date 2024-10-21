output "k3s_sg_id" {
  value = aws_security_group.k3s.id
}

output "lb_sg_id" {
  value = aws_security_group.lb.id
}