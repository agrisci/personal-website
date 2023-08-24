resource "aws_key_pair" "ssh_pub_key" {
  key_name   = "ssh_pub_key"
  public_key = file(var.ssh_public_key_file)
}

resource "aws_instance" "ecs_instance_1a" {
  instance_type          = "t2.micro"
  ami                    = "ami-083981ad0228be819"
  key_name               = aws_key_pair.ssh_pub_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_instances_sg.id]
  subnet_id              = aws_subnet.public_subnet_a.id
  iam_instance_profile   = aws_iam_instance_profile.ecs_agent.name
  user_data              = file("user_data.tpl")
}
