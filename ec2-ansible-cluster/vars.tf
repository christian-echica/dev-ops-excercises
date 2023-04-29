# control node variables 
variable "instance_name_control" {
        description = "Name of the instance to be created"
        default = "control-node"
}

variable "instance_type_control" {
        default = "t2.micro"
}

variable "subnet_id_control" {
        description = "The VPC subnet the instance(s) will be created in"
        # default = "subnet-08f83d21dc8b1859b"
        default = "subnet-0106bffedfdbcc771"
}

variable "ami_id_control" {
        description = "The AMI to use"
        # default = "ami-03c7d01cf4dedc891"
        default = "ami-03c7d01cf4dedc891"
}

variable "number_of_instances_control" {
        description = "number of control node instances to be created"
        default = 1
}

# manage node variables 

variable "instance_name_manage" {
        description = "Name of the instance to be created"
        default = "manage-node"
}

variable "instance_type_manage" {
        default = "t2.micro"
}

variable "subnet_id_manage" {
        description = "The VPC subnet the instance(s) will be created in"
        # default = "subnet-08f83d21dc8b1859b"
        default = "subnet-0106bffedfdbcc771"
}

variable "ami_id_manage" {
        description = "The AMI to use"
        # default = "ami-03c7d01cf4dedc891"
        default = "ami-03c7d01cf4dedc891"
}

variable "number_of_instances_manage" {
        description = "number of manage node instances to be created"
        default = 1
}

variable "private_key_path" {
  description = "The path to the private key used for ssh-copy-id"
  default = "/home/sagemaker/keypair-central/devops-acloud.pem"
}
