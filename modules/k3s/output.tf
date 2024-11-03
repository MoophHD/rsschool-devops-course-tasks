output "k3s_server_private_ip" {
  value = aws_instance.k3s_server.private_ip
}

output "k3s_security_group_id" {
  value = aws_security_group.k3s.id
}
