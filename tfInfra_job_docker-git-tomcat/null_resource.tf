resource "null_resource" "copy_script" {
  # Change the IP address to your instance's public IP
  # Change the user to your instance's SSH user
  # This assumes your private key is located in the same directory as this Terraform script
  connection {
    type        = "ssh"
    host        = aws_instance.tomcat_server.public_ip
    user        = "ec2-user"
    private_key = file("${path.module}/${var.KEY_PAIR}.pem")
  }
}
