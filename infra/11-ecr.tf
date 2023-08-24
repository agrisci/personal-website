resource "aws_ecr_repository" "personal_website_main_repository" {
  name                 = "personal-website-main"
  image_tag_mutability = "MUTABLE"
  force_delete         = false

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "personal_website_develop_repository" {
  name                 = "personal-website-develop"
  image_tag_mutability = "MUTABLE"
  force_delete         = false

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "personal_website_main_repository_policy" {
  repository = aws_ecr_repository.personal_website_main_repository.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 4 untagged images",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 4
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "personal_website_develop_repository_policy" {
  repository = aws_ecr_repository.personal_website_develop_repository.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 4 untagged images",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 4
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}