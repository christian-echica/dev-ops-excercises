resource "aws_instance" "tomcat_server" {
  ami           = var.AWS_AMI_ID
  instance_type = var.AWS_INSTANCE_TYPE
  key_name      = var.KEY_PAIR
  subnet_id     = var.SUBNET_ID
  vpc_security_group_ids = [var.SECURITY_GROUP]

  tags = {
    Name = var.SERVER_NAME
  }

  root_block_device {
    volume_size = var.AWS_VOLUME_SIZE
    volume_type = var.AWS_VOLUME_TYPE
    delete_on_termination = true
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/${var.KEY_PAIR}.pem")
    host        = self.public_ip
  }
}
