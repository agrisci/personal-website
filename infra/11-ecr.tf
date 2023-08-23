resource "aws_ecr_repository" "devops_portfolio_main_repository" {
  name                 = "devops-portfolio-main"
  image_tag_mutability = "MUTABLE"
  force_delete         = false

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "devops_portfolio_develop_repository" {
  name                 = "devops-portfolio-develop"
  image_tag_mutability = "MUTABLE"
  force_delete         = false

  image_scanning_configuration {
    scan_on_push = true
  }
}