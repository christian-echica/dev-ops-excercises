variable "instance_name" {
        description = "Name of the instance to be created"
        default = "tomcat-server"
}

variable "instance_type" {
        default = "t2.medium"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "subnet-08f83d21dc8b1859b"
}

variable "ami_id" {
        description = "The AMI to use"
        default = "ami-03c7d01cf4dedc891"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}


