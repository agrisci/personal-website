resource "aws_key_pair" "minikube_auth" {
  key_name   = "minikube_key"
  public_key = file(var.ssh_public_key_file)
}

resource "aws_instance" "minikube" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.latest_ubuntu_22_ami.id
  key_name               = aws_key_pair.minikube_auth.key_name
  vpc_security_group_ids = [aws_security_group.minikube_sg.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 20
  }

  tags = {
    name = "minikube"
  }
}