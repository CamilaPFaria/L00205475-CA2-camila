variable "aws_region" {
  description = "Region where the resources will be created"
  type        = list(string)
  default     = ["eu-west-1", "eu-central-1"]
}
variable "aws_AZ" {
  description = "Availability zone where the resources will be created"
  type        = list(string)
}

variable "aws_instance" {
    description = "Instance type for the EC2 instance"
    type        =  string
    default     =  "t3.micro"
}
variable "aws_ebs_volume" {
    description = "EBS volume size in GB"
    type        =  number
    
}
