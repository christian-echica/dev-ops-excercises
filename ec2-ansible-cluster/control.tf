resource "aws_instance" "ec2_instance_control" {
  ami = "${var.ami_id_control}"
  count = "${var.number_of_instances_control}"
  subnet_id = "${var.subnet_id_control}"
  instance_type = "${var.instance_type_control}"
  key_name = "devops-acloud"

   tags = {
    Name = "control-node"
    Environment = "dev"
  } 

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/home/sagemaker/keypair-central/devops-acloud.pem")
    timeout = "2m"
    host = aws_instance.ec2_instance_control[count.index].public_ip
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
      # Inventory will be /home/ec2-user/inventory
      "cat > inventory <<EOF\n[control]\nlocalhost ansible_connection=local\nEOF",
      "cat > ansible.cfg <<EOF\n[defaults]\ninventory = ./inventory\nEOF",
      "sudo mkdir -p ~/.ssh",
      "ssh-keygen -t rsa -q -N '' -f ~/.ssh/id_rsa",
      "echo 'Newly generated keygen: '",
      "cat ~/.ssh/id_rsa.pub"      
    ]
  }
}
