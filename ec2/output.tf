output "public-instance-1" {
  value = aws_instance.public-instance-1.id
}
output "public-instance-2" {
  value = aws_instance.public-instance-2.id
}
output "private-instance-1" {
  value = aws_instance.private-instance1.id
}
output "private-instance-2" {
  value = aws_instance.private-instance2.id
}