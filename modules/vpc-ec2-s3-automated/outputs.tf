output "bucket" {
  value       = aws_s3_bucket.CHANGEME-bucket.id
  description = "Bucket Name"
}

output "ssh_command" {
  value = ["Run this command to connect: ssh -i ~/.ssh/CHANGEME_ssh_key.pub.pem ubuntu@${aws_instance.CHANGEME_instance.public_ip}"]
}
