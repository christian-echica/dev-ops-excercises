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
    private_key = file("${path.module}/devops-dude.pem")
  }

  # Copy the install_tomcat.sh script to the instance
  provisioner "file" {
    source      = "install_tomcat.sh"
    destination = "/tmp/install_tomcat.sh"
  }

  # Copy the tomcat.service file to the instance
  provisioner "file" {
    source      = "tomcat.service"
    destination = "/tmp/tomcat.service"
  }

  # Copy the tomcat-users.xml file to the instance
  provisioner "file" {
    source      = "tomcat-users.xml"
    destination = "/tmp/tomcat-users.xml"
  }

  # Copy the context.xml file to the instance
  provisioner "file" {
    source      = "context.xml"
    destination = "/tmp/context.xml"
  }

  # Copy the host-manager-context.xml file to the instance
  provisioner "file" {
    source      = "host-manager-context.xml"
    destination = "/tmp/host-manager-context.xml"
  }

  # Copy the host-manager-server.xml file to the instance
  provisioner "file" {
    source      = "host-manager-server.xml"
    destination = "/tmp/host-manager-server.xml"
  }

  # Execute the script and wait for the instance to become available again
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_tomcat.sh",
      "/bin/bash -c '/tmp/install_tomcat.sh 2>&1'"
    ]
    connection {
      type        = "ssh"
      host        = var.instance_ip
      user        = "ec2-user"
      private_key = file("${path.module}/devops-dude.pem")
    }
    on_failure = continue
  }

  # Stop and start the Tomcat service
  provisioner "remote-exec" {
    inline = [
      "sudo systemctl stop tomcat",
      "sudo systemctl start tomcat"
    ]
    connection {
      type        = "ssh"
      host        = var.instance_ip
      user        = "ec2-user"
      private_key = file("${path.module}/devops-dude.pem")
    }
  }
}
