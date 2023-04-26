variable "SERVER_NAME" {
  default = "tomcat-server"
}

variable "AWS_ACCESS_KEY_ID" {
  default = "AKIAW635LUPZ6PPG2D53"
}

variable "AWS_SECRET_ACCESS_KEY" {
  default = "9AbxskNd+8BKdfCgBAvENRnEPXQ6TIbqdkDwEFyn"
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AWS_INSTANCE_TYPE" {
  default = "t2.medium"
}

variable "AWS_VOLUME_SIZE" {
  default = 8
}

variable "AWS_VOLUME_TYPE" {
  default = "gp2"
}

variable "AWS_VOLUME_DEVICE" {
  default = "/dev/xvda"
}

variable "AWS_AMI_ID" {
  default = "ami-03c7d01cf4dedc891"
}

variable "KEY_PAIR" {
  default = "devops-dude"
}

variable "SUBNET_ID" {
  default = "subnet-08f83d21dc8b1859b"
}

variable "SECURITY_GROUP" {
  default = "sg-09b86e8974d3c9b9e"
}

variable "instance_ip" {
  description = "Public IP address of the EC2 instance"
}
