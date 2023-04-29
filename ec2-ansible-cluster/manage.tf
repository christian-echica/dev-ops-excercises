resource "aws_instance" "ec2_instance_manage" {
  ami = "${var.ami_id_manage}"
  count = "${var.number_of_instances_manage}"
  subnet_id = "${var.subnet_id_manage}"
  instance_type = "${var.instance_type_manage}"
  key_name = "devops-acloud"

  tags = {
    Name = "manage-node"
    Environment = "dev"
  }  

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/home/sagemaker/keypair-central/devops-acloud.pem")
    timeout = "2m"
    host = aws_instance.ec2_instance_manage[count.index].public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y yum-utils",
      "echo 'ansibleadmin' | sudo passwd --stdin ec2-user",
      "echo 'ec2-user ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers",
      "USERNAME='ec2-user' && sudo sh -c \"echo '$USERNAME ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers\"",
      "sudo yum install ansible -y",
      "sudo yum install -y openssh-server",
      "sudo systemctl enable sshd",
      "sudo systemctl start sshd"   
    ]
  }
}
