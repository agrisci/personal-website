##### ECS-Cluster #####
resource "aws_ecs_cluster" "cluster" {
  name = "ecs-cluster"
}

##### AWS ECS-TASKS #####
resource "aws_ecs_task_definition" "personal_website_develop_task_definition" {
  container_definitions    = data.template_file.personal_website_develop_template.rendered
  family                   = "personal-website-develop"
  network_mode             = "bridge"
  memory                   = "256"
  cpu                      = "256"
  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_task_definition" "personal_website_main_task_definition" {
  container_definitions    = data.template_file.personal_website_main_template.rendered
  family                   = "personal-website-main"
  network_mode             = "bridge"
  memory                   = "256"
  cpu                      = "256"
  requires_compatibilities = ["EC2"]
}

data "template_file" "personal_website_develop_template" {
  template = file("task_definition.json")

  vars = {
    CONTAINER_NAME  = aws_ecr_repository.personal_website_develop_repository.name
    CONTAINER_IMAGE = format("%s%s", aws_ecr_repository.personal_website_develop_repository.repository_url, ":latest")
    PORT            = 5000
  }
}

data "template_file" "personal_website_main_template" {
  template = file("task_definition.json")

  vars = {
    CONTAINER_NAME  = aws_ecr_repository.personal_website_main_repository.name
    CONTAINER_IMAGE = format("%s%s", aws_ecr_repository.personal_website_main_repository.repository_url, ":latest")
    PORT            = 5001
  }
}

##### AWS ECS-SERVICES #####
resource "aws_ecs_service" "personal_website_develop_service" {
  cluster                            = aws_ecs_cluster.cluster.id
  desired_count                      = 1
  launch_type                        = "EC2"
  name                               = "personal-website-develop-service"
  task_definition                    = aws_ecs_task_definition.personal_website_develop_task_definition.arn
  deployment_minimum_healthy_percent = 0
}

resource "aws_ecs_service" "personal_website_main_service" {
  cluster                            = aws_ecs_cluster.cluster.id
  desired_count                      = 1
  launch_type                        = "EC2"
  name                               = "personal-website-main-service"
  task_definition                    = aws_ecs_task_definition.personal_website_main_task_definition.arn
  deployment_minimum_healthy_percent = 0
}