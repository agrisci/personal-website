#!/bin/bash
# Update all packages
sudo yum update -y

#Adding cluster name in ecs config
echo ECS_CLUSTER=ecs-cluster >> /etc/ecs/ecs.config