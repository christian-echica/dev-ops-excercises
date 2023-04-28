provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/sagemaker/.aws/credentials"
  profile = "default"
}

resource "aws_instance" "ec2_instance" {
  ami = "${var.ami_id}"
  count = "${var.number_of_instances}"
  subnet_id = "${var.subnet_id}"
  instance_type = "${var.instance_type}"
  key_name = "devops-dude"

  connection {
      type = "ssh"
      user = "ec2-user"
      # private_key = file("${path.module}/devops-dude.pem")
      private_key = file("/home/sagemaker/keypair-central/devops-dude.pem")
      timeout = "2m"
      host = aws_instance.ec2_instance[count.index].public_ip
  }

  provisioner "file" {
      source = "install_ansible.sh"
      destination = "/tmp/install_ansible.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_ansible.sh",
      "sudo /tmp/install_ansible.sh"
    ]
  }
}
