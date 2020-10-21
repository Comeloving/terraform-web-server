output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "instance_public_ip" {
  value = aws_instance.Server[count.index]
}