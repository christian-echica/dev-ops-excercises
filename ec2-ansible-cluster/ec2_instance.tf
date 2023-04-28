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

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y yum-utils",
      "sudo yum install -y python",
      "sudo yum install -y python-pip",
      "sudo pip install ansible",
      "ansible --version",
      "echo 'ansibleadmin' | sudo passwd --stdin ec2-user",
      "echo 'ec2-user ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers",
      "USERNAME='ec2-user' && sudo sh -c \"echo '$USERNAME ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers\"",
      "sudo yum install ansible -y",
      "sudo yum install -y openssh-server",
      "sudo systemctl enable sshd",
      "sudo systemctl start sshd",
      "cat > inventory <<EOF\n[control]\nlocalhost ansible_connection=local\nEOF",
      "cat > ansible.cfg <<EOF\n[defaults]\ninventory = ./inventory\nEOF",
      "sudo mkdir -p ~/.ssh",
      "ssh-keygen -t rsa -q -N '' -f ~/.ssh/id_rsa"
    ]
  }
}
