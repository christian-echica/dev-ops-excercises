#!/bin/bash
set -e

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

# DOCKER INSTALLATION
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# DOCKER-COMPOSE INSTALLATION
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# TOMCAT 10 INSTALLATION 
# Add Tomcat group
sudo groupadd tomcat

# Create tomcat user, disable login and give rights
sudo useradd -s /bin/nologin -g tomcat -d /opt/tomcat tomcat

# Install WGET
sudo yum -y install wget

# Download Tomcat 10.0.22
VER=10.0.22
wget https://archive.apache.org/dist/tomcat/tomcat-10/v${VER}/bin/apache-tomcat-${VER}.tar.gz

# Extract to /opt/tomcat directory
sudo tar -xvf apache-tomcat-$VER.tar.gz -C /opt/tomcat --strip-components=1

# Allow Tomcat user to access the files in tomcat directory
sudo chown -R tomcat: /opt/tomcat

# Make the scripts in the directory executable
sudo sh -c 'chmod +x /opt/tomcat/bin/*.sh'

# Copy the tomcat.service to /etc/systemd.system folder
sudo cp /tmp/tomcat.service /etc/systemd/system/tomcat.service

# Copy tomcat-users.xml to /opt/tomcat/conf/tomcat-users.xml
sudo cp /tmp/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml

# Copy context.xml to /opt/tomcat/webapps/manager/META-INF/context.xml
sudo cp /tmp/context.xml /opt/tomcat/webapps/manager/META-INF/context.xml

# Copy host-manager-context.xml to /opt/tomcat/webapps/host-manager/META-INF/context.xml
sudo cp /tmp/host-manager-context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml

# Copy host-manager-server.xml to /opt/tomcat/conf/server.xml
sudo cp /tmp/host-manager-server.xml /opt/tomcat/conf/server.xml

# Change all permissions for /opt
sudo chmod -R a+rwX /opt

# Add ec2-user as admin for later use
USERNAME="ec2-user"
sudo sh -c "echo '$USERNAME ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
exit 0

# Start and Enable the tomcat service
sudo systemctl daemon-reload
sudo systemctl enable --now tomcat
sudo systemctl start tomcat

# Install for jar
sudo yum install java-1.8.0-openjdk-devel -y

