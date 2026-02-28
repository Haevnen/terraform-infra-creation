// After running "terraform apply". It will print instance_id and public_ip
// so that root module can access these value
output "instance_id" {
  value = aws_instance.jenkins.id
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}