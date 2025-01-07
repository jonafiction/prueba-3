# ECR Repo
resource "aws_ecr_repository" "app_repository" {
  name                 = "${var.prueba_3}-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.prueba_3}-repo"
    Environment = var.environment
  }
}

# Política de lifecycle para mantener solo las últimas 5 imágenes
resource "aws_ecr_lifecycle_policy" "app_repository_policy" {
  repository = aws_ecr_repository.app_repository.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Mantener solo las últimas 5 imágenes"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}