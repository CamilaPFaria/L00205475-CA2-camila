variable "aws_region" {
  description = "Region where the resources will be created"
  type        = string
  default     = "eu-west-1"
}
variable "aws_AZ" {
  description = "Availability zone where the resources will be created"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "aws_instance" {
    description = "Instance type for the EC2 instance"
    type        =  string
    default     =  "t3.micro"
}
variable "aws_ebs_volume" {
    description = "EBS volume size in GB"
    type        =  number
    default     =  20
    
}
variable "vpc_id" {
  description = "ID of the VPC where the Security Group will be created"
  type        = string
  default     = "vpc-default" # Replace with your specific VPC ID
}

variable "admin_ip" {
  description = "Trusted IP for administrative SSH access"
  type        = string
  default     = "109.255.0.1/32" # Replace with your specific IP/subnet
}
