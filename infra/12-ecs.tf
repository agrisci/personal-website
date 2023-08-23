##### ECS-Cluster #####
resource "aws_ecs_cluster" "cluster" {
  name = "ecs-cluster"
}

##### AWS ECS-TASKS #####
resource "aws_ecs_task_definition" "devops_portfolio_develop_task_definition" {
  container_definitions    = data.template_file.devops_portfolio_develop_template.rendered # task defination json file location
  family                   = "devops-portfolio-develop"                                    # task name
  network_mode             = "bridge"                                                      # network mode awsvpc, brigde
  memory                   = "256"
  cpu                      = "256"
  requires_compatibilities = ["EC2"] # Fargate or EC2
}

resource "aws_ecs_task_definition" "devops_portfolio_main_task_definition" {
  container_definitions    = data.template_file.devops_portfolio_main_template.rendered # task defination json file location
  family                   = "devops-portfolio-main"                                    # task name
  network_mode             = "bridge"                                                   # network mode awsvpc, brigde
  memory                   = "256"
  cpu                      = "256"
  requires_compatibilities = ["EC2"] # Fargate or EC2
}

data "template_file" "devops_portfolio_develop_template" {
  template = file("task_definition.json")

  vars = {
    CONTAINER_NAME  = aws_ecr_repository.devops_portfolio_develop_repository.name
    CONTAINER_IMAGE = format("%s%s", aws_ecr_repository.devops_portfolio_develop_repository.repository_url, ":latest")
    PORT            = 5000
  }
}

data "template_file" "devops_portfolio_main_template" {
  template = file("task_definition.json")

  vars = {
    CONTAINER_NAME  = aws_ecr_repository.devops_portfolio_main_repository.name
    CONTAINER_IMAGE = format("%s%s", aws_ecr_repository.devops_portfolio_main_repository.repository_url, ":latest")
    PORT            = 5001
  }
}

##### AWS ECS-SERVICES #####
resource "aws_ecs_service" "devops-portfolio-develop-service" {
  cluster                            = aws_ecs_cluster.cluster.id                                           # ECS Cluster ID
  desired_count                      = 1                                                                    # Number of tasks running
  launch_type                        = "EC2"                                                                # Cluster type [ECS OR FARGATE]
  name                               = "devops-portfolio-develop-service"                                   # Name of service
  task_definition                    = aws_ecs_task_definition.devops_portfolio_develop_task_definition.arn # Attach the task to service
  deployment_minimum_healthy_percent = 0
}

resource "aws_ecs_service" "devops-portfolio-main_service" {
  cluster                            = aws_ecs_cluster.cluster.id                                        # ECS Cluster ID
  desired_count                      = 1                                                                 # Number of tasks running
  launch_type                        = "EC2"                                                             # Cluster type [ECS OR FARGATE]
  name                               = "devops-portfolio-main-service"                                   # Name of service
  task_definition                    = aws_ecs_task_definition.devops_portfolio_main_task_definition.arn # Attach the task to service
  deployment_minimum_healthy_percent = 0
}