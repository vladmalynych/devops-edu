variable "ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type (e.g., t2.micro)"
}

variable "instance_name" {
  type        = string
  description = "Name for the EC2 instance"
}

variable "region" {
  type        = string
  description = "The AWS region"
}

variable "environment" {
  type        = string
  description = "Environment (e.g., dev, prod)"
}
