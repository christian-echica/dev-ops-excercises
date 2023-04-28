#!/bin/bash
set -eux

# Update the system
sudo yum update -y

# Install Amazon extras
sudo yum install -y yum-utils
sudo yum install -y python
sudo yum install -y python-pip
sudo pip install ansible
ansible --version

# Change all permissions sample 
# sudo chmod -R a+rwX /opt

# Set password for ec2-user user
echo "ansibleadmin" | sudo passwd --stdin ec2-user

# Grant sudo access to ec2-user user
echo "ec2-user ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# Add ec2-user as admin for later use
USERNAME="ec2-user"
sudo sh -c "echo '$USERNAME ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"

# Install Ansible
sudo yum install ansible -y
sudo yum install -y openssh-server

# Enable and start the sshd service
sudo systemctl enable sshd
sudo systemctl start sshd

# Create the Ansible inventory file
cat > inventory <<EOF
[control]
localhost ansible_connection=local
EOF

# Create the Ansible configuration file
cat > ansible.cfg <<EOF
[defaults]
inventory = ./inventory
EOF

# Generate keygen automation (this command will overwrite if there is any existing)
# sudo mkdir -p ~/.ssh
# ssh-keygen -t rsa -q -N "" -f ~/.ssh/id_rsa

# Exit with status 0 (success)
# exit 0
