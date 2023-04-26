resource "aws_instance" "ec2_instance" {
    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}"

    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("${path.module}/devops-dude.pem")
        timeout = "2m"
        host = aws_instance.ec2_instance[count.index].public_ip
    }

    provisioner "file" {
        source = "install_tomcat.sh"
        destination = "/tmp/install_tomcat.sh"
    }

    provisioner "file" {
        source = "tomcat.service"
        destination = "/tmp/tomcat.service"
    }

    provisioner "file" {
        source = "tomcat-users.xml"
        destination = "/tmp/tomcat-users.xml"
    }

    provisioner "file" {
        source = "context.xml"
        destination = "/tmp/context.xml"
    }

    provisioner "file" {
        source = "host-manager-context.xml"
        destination = "/tmp/host-manager-context.xml"
    }

    provisioner "file" {
        source = "host-manager-server.xml"
        destination = "/tmp/host-manager-server.xml"
    }

    provisioner "remote-exec" {
      inline = [
        "set -eux",
        "chmod +x /tmp/install_tomcat.sh",
        "sudo /tmp/install_tomcat.sh",
        "sudo systemctl start tomcat"
      ]
    }
}
