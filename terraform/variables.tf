variable "aws_region" {
  type        = string
  description = "AWS deployment region enforcing EU sovereignty"
  default     = "us-east-1"
}

variable "availability_zone" {
  type        = string
  description = "Target availability zone for EC2 instances and EBS volume"
  default     = "eu-west-1a"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance size for web and database workloads"
  default     = "t3.micro"
}

variable "db_volume_size" {
  type        = number
  description = "Size of the database EBS volume in GB"
  default     = 50
}

variable "db_device_name" {
  type        = string
  description = "Attachment device name for database volume"
  default     = "/dev/sdh"
}

variable "sovereignty_tag" {
  type        = string
  description = "Tag enforcing data residency compliance"
  default     = "EU-only"
}