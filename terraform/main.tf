# Ireland is the default deployment region for the resources considering the sovereignty and data residency requirements of the EU.
provider "aws" {
  region = var.aws_region
}

resource "aws_default_vpc" "default" {
  tags = { Name = "Default VPC" }
}

# Use data sources to query AWS for information about existing resources. 
# In this case, the latest Ubuntu AMI will be queried and used to launch EC2 instances in the specified regions.
# Ref.: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}

# Web Server EC2 instance using parameterized settings
resource "aws_instance" "web" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  tags              = { Name = "Web Server", Sovereignty = var.sovereignty_tag }

  # The metadata_options block is used to configure the instance metadata service (IMDS) settings for the EC2 instance.
  # Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_metadata_defaults
  metadata_options {
    http_tokens   = "required" # Enforces IMDSv2
    http_endpoint = "enabled"  # Enables metadata service
  }

  root_block_device {
    encrypted = true
  }
}

# EC2 instance to host the database server.
resource "aws_instance" "db-server" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  tags              = { Name = "Database server", Sovereignty = var.sovereignty_tag }

  metadata_options {
    http_tokens   = "required" # Enforces IMDSv2
    http_endpoint = "enabled"  # Enables metadata service
  }

  root_block_device {
    encrypted = true
  }
}

# Enables default EBS encryption across the account/region
resource "aws_ebs_encryption_by_default" "enable" {
  enabled = true
}

# EBS volume to be attached to the database server instance.
resource "aws_ebs_volume" "database" {
  availability_zone = var.availability_zone
  size              = var.db_volume_size
  encrypted         = true
  tags              = { Name = "Database Volume", Sovereignty = var.sovereignty_tag }
}

resource "aws_volume_attachment" "db-attach" {
  device_name = var.db_device_name
  volume_id   = aws_ebs_volume.database.id
  instance_id = aws_instance.db-server.id
}

resource "aws_security_group" "web-server-sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and restricted SSH"
  vpc_id      = aws_default_vpc.default.id # Explicit link ensures clean dependency graph

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Database Security Group: Denies all public access, allows ONLY Web SG
resource "aws_security_group" "db-server-sg" {
  name        = "db-server-sg"
  description = "Security group for database server - no public ingress"
  vpc_id      = aws_default_vpc.default.id

  # Inbound Rule: Allow connections STRICTLY from Web SG (Port 5432 for PostgreSQL)
  ingress {
    description     = "Allow database access exclusively from web tier"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web-server-sg.id] # Security Group Chaining
  }

  # Inbound Rule: Restricted SSH for admin maintenance
  ingress {
    description = "Restricted SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  # Outbound Rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-server-sg"
  }
}