#Ireland is the default deployment region for the resources considering the sovereignty and data residency requirements of the EU.
provider "aws" {
  region = "eu-west-1" 
}
#Use data sources to query AWS for information about existing resources. 
#In this case, the latest Ubuntu AMI will be queried and used to launch EC2 instances in the specified regions.
#Ref.: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}
#In order to guarantee high availability and fault tolerance, the resources will be deployedin a second european region, Frankfurt.
provider "aws"{
    alias = Frankfurt
    region = "eu-central-1" 
}
#Instance type is set to t3.micro, which is a cost-effective option for small workloads and testing purposes.
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  availability_zone = var.aws_AZ[0]
  tags = {
    Name = "Web Server $"
    Sovereignty = "EU-only"
  }
}
#The data needs to be stored in European regions, so the resouces will be deployed in Ireland and Frankfurt. 
resource "aws_ebs_volume" "database"{ 
    availability_zone = var.aws_AZ[0]
    size              =  10
    encrypted = true 
    tags = {
        Name = "Database Volume $"
        Sovereignty = "EU-only"
    }
}    
#it makes sure that the data is encrypted for all ebs resources created in the account even if not explicitly specified in the resource definition.
resource "aws_ebs_encryption_by_default" "enable" {
  enabled = true
}


