# SQS Queue
resource "aws_sqs_queue" "main_queue" {
  name = "${var.prueba_3}-queue"

  tags = {
    Environment = var.environment
  }
}

# SNS Topic
resource "aws_sns_topic" "notifications" {
  name = "${var.prueba_3}-notifications"
}

# IAM Role para Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.prueba_3}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy para Lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.prueba_3}-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.main_queue.arn
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish"
        ]
        Resource = aws_sns_topic.notifications.arn
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Lambda Function
resource "aws_lambda_function" "processor" {
  filename      = "lambda/function.zip"
  function_name = "${var.prueba_3}-processor"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.notifications.arn
      QUEUE_URL     = aws_sqs_queue.main_queue.url
    }
  }

  tags = {
    Environment = var.environment
  }
}

# Event Source Mapping (Conecta SQS con Lambda)
resource "aws_lambda_event_source_mapping" "sqs_lambda" {
  event_source_arn = aws_sqs_queue.main_queue.arn
  function_name    = aws_lambda_function.processor.arn
  batch_size       = 1
}

# Política de SQS para permitir que Lambda procese mensajes
resource "aws_sqs_queue_policy" "lambda_queue_policy" {
  queue_url = aws_sqs_queue.main_queue.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action   = "sqs:*"
        Resource = aws_sqs_queue.main_queue.arn
      }
    ]
  })
}