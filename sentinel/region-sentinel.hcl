#Create policiy definitions

#== The configured *enforcement_level* for your policy. A policy can have one of three enforcement levels:
#Advisory (default): The policy can fail. HCP Terraform records all failures in the audit log.
#Soft mandatory: In the event of failure, organization owners or users with override permissions can override the policy to let the run proceed. HCP Terraform records all overrides in the audit log.
#Hard mandatory: The policy must pass for the run to proceed.
#If enforcement_level is not supplied, it will fallback to the advisory level.
#== Ref.: https://developer.hashicorp.com/terraform/tutorials/policy/sentinel-cloud-integration
import "tfplan/v2" as plan

#configure the policy to allow only Ireland and franfkfurt regions. 
policy "restrict-aws-region"{
    source            = "./restrict-aws-region.region-sentinel.hcl"
    enforcement_level = hard_mandatory
}




