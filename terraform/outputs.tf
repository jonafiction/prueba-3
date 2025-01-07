output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "ec2_instance_ip" {
  value = aws_instance.api_server.public_ip
}

output "sqs_queue_url" {
  value = aws_sqs_queue.main_queue.url
}

output "sns_topic_arn" {
  value = aws_sns_topic.notifications.arn
}