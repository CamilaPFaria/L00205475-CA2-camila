#Ireland is the default deployment region for the resources considering the sovereignty and data residency requirements of the EU.
provider "aws" {
  region = "eu-west-1" 
}
#In order to guarantee high availability and fault tolerance, the resources will be deployedin a second european region, Frankfurt.
provider "aws"{
    alias = Frankfurt
    region = "eu-central-1" 
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


