#!/bin/bash

# Update the system
sudo yum update -y


# Install Amazon extras
sudo yum install -y yum-utils
sudo yum install amazon-linux-extras -y

# Install git
sudo yum install -y git

# Install Java 11
sudo amazon-linux-extras install java-openjdk11 -y

# Install nc (netcat)
sudo yum install nc -y


# Install WGET
sudo yum -y install wget


# Install dependencies
sudo yum install -y docker git

# Change permission 
sudo chmod 777 -R /var/run/docker.sock

# Add current user to docker group
sudo usermod -aG docker $USER

# Start Docker service
sudo service docker start



# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# Add ec2-user as admin for later use
USERNAME="ec2-user"
sudo sh -c "echo '$USERNAME ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
exit 0

# Start and Enable the jenkins service
sudo systemctl start jenkins

# Enable Jenkins service on startup
sudo systemctl enable jenkins