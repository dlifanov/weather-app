resource "aws_ecr_repository" "aws_ecr" {
  name                 = "weather-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}