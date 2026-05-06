output "eip_allocation_id" {
  value = aws_eip.main.id
}

output "eip_public_ip" {
  value = aws_eip.main.public_ip
}