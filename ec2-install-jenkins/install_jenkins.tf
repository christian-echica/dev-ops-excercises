# Define the provider block
provider "aws" {
  region = "us-east-1"
}

# Define the null_resource block
resource "null_resource" "copy_script" {
  # Change the IP address to your instance's public IP
  # Change the user to your instance's SSH user
  # This assumes your private key is located in the same directory as this Terraform script
  connection {
    type        = "ssh"
    host        = var.instance_ip
    user        = "ec2-user"
    private_key = file("/home/sagemaker/keypair-central/devops-dude.pem")
  }

  # Copy the install_jenkins.sh script to the instance
  provisioner "file" {
    source      = "install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
  }

  # Set the correct file permissions for the script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_jenkins.sh"
    ]
    connection {
      type        = "ssh"
      host        = var.instance_ip
      user        = "ec2-user"
      private_key = file("/home/sagemaker/keypair-central/devops-dude.pem")
    }
  }

  # Execute the script and wait for the instance to become available again
  provisioner "remote-exec" {
    inline = [
      "/bin/bash /tmp/install_jenkins.sh"
    ]
    connection {
      type        = "ssh"
      host        = var.instance_ip
      user        = "ec2-user"
      private_key = file("/home/sagemaker/keypair-central/devops-dude.pem")
    }
  }

  # Stop and start the Jenkins service
  provisioner "remote-exec" {
    inline = [
      "sudo systemctl daemon-reload",
      "sudo systemctl stop jenkins",
      "sudo systemctl start jenkins"
    ]
    connection {
      type        = "ssh"
      host        = var.instance_ip
      user        = "ec2-user"
      private_key = file("/home/sagemaker/keypair-central/devops-dude.pem")
    }
  }
}
