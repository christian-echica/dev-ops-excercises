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

# Set the desired version of Jenkins
JENKINS_VERSION="2.164.1"

# Add Jenkins repository key
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins and its dependencies
sudo yum install -y jenkins


# Add ec2-user as admin for later use
USERNAME="ec2-user"
sudo sh -c "echo '$USERNAME ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
exit 0

# Start and Enable the jenkins service
sudo systemctl start jenkins

# Enable Jenkins service on startup
sudo systemctl enable jenkins