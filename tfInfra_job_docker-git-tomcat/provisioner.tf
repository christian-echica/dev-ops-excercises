resource "null_resource" "install_tomcat" {
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y git",
      "git clone https://github.com/christian-echica/dev-ops-excercises.git /opt/tomcat/webapps/repo/tfInfra_job_docker-git-tomcat",
      "chmod +x /opt/tomcat/webapps/repo/tfInfra_job_docker-git-tomcat/install_tomcat.sh",
      "/bin/bash -c '/opt/tomcat/webapps/repo/tfInfra_job_docker-git-tomcat/install_tomcat.sh 2>&1'"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/${var.KEY_PAIR}.pem")
      host        = aws_instance.tomcat_server.public_ip
    }
    on_failure = continue
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl stop tomcat",
      "sudo systemctl start tomcat"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/${var.KEY_PAIR}.pem")
      host        = aws_instance.tomcat_server.public_ip
    }
  }
}
