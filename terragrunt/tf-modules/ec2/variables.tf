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

variable "subnet_id" {
  type        = string
  description = "AWS VPC subnet id"
}

variable "security_group_ids" {
  type        = list(string)
  description = "AWS security group id"
}
