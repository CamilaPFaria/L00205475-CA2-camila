# L00205475-CA2-camila
CA2 for the IaC Devops pipelines module

# CA2 for the IaC DevOps Pipelines Module

---

## Policy as Code & Digital Sovereignty Overview

**Policy as Code (PaC)** is a fundamental approach to enforcing digital sovereignty. Having automated guardrails to ensure an organization's infrastructure continuously adheres to required governance standards is critical, given the rapid pace of technological development and continuous deployment cycles.

However, inherent limitations exist within cloud environments. Even when data is stored within a specific geographical region, the underlying physical hardware may still be managed by foreign personnel or entity structures. 

Consequently, complete digital sovereignty is not fully achievable in a public cloud environment in the same manner as an on-premises architecture. Furthermore, major cloud service providers (such as AWS and Azure) remain subject to US laws—such as the **US CLOUD Act**—regardless of whether their physical servers reside within European borders. This introduces significant legal and jurisdictional complexity when guaranteeing total digital sovereignty.

---

## Technical Justifications Based on DORA, ISO, and Digital Sovereignty

The following requirements and considerations were identified to improve infrastructure security, resilience, and alignment with digital sovereignty principles:

1. **EU Regional Deployment**  
   Resources should be deployed only in EU regions to ensure that infrastructure and data remain within European jurisdictions.

2. **Data Encryption**  
   All data must be encrypted both at rest and in transit to guarantee data confidentiality and security.

3. **Multi-Region Deployment**  
   Resources should be deployed in another European region to guarantee disaster recovery and availability, which are requirements under DORA. This ensures that if one AWS data centre experiences an outage, the application remains running in the second region, satisfying resilience and high-availability requirements under DORA while keeping all data within the EU.

4. **Access Control**  
   Access to resources from regions outside Europe should be restricted and controlled to improve security and maintain control over the infrastructure.

5. **End-to-End Encryption**  
   Critical communication platforms should implement end-to-end encryption to guarantee the confidentiality and security of communications.  
   *(Note: Out of scope for this implementation).*

6. **Database Security**  
   Databases should be located in European regions and use encryption to protect stored data.

---

## Conclusion

Policy as Code provides an important foundation for automating security and compliance requirements. However, achieving complete digital sovereignty in cloud environments remains challenging due to jurisdictional, operational, and infrastructure-related limitations.

The requirements identified above provide a foundation for improving infrastructure security, operational resilience, and alignment with DORA, ISO standards, and European digital sovereignty principles.

---

### Core Technologies & Regulatory Standards
`AWS` | `Terraform` | `Sentinel` | `DORA` | `ISO` | `Digital Sovereignty`

---

## Declaration of AI Assistance

In accordance with academic integrity guidelines, I declare that I utilized the Google Gemini (Gemini 3.6 Flash) AI assistant as a learning partner, thought partner, and code reviewer during the development of this assignment. The specific ways AI was incorporated into this project include:

### Phase 1: HashiCorp Sentinel & Policy Development Logic

* **Initial Setup & Core Requirements:** Discussions around enforcing EC2 security configurations using `tfplan/v2` in Sentinel (restricting instance types to `t3.micro`/`t3.small`, enforcing IMDSv2 via `http_tokens = "required"`, and mandatory EBS encryption).
* **Sentinel Schema & Data Navigation:** Inquiries into direct property pathing, indexing list items (e.g., understanding why `metadata_options[0]` opens the single map block inside a list), and evaluating inline statements vs. local variables.
* **Inline Rules vs. Helper Functions:** Questions comparing direct inline evaluation inside `main = rule` against writing helper functions, favoring simple, beginner-friendly inline code for the assignment.

---

### Phase 2: Sentinel Testing & Testing Workflows

* **Sentinel CLI Testing Workflow:** Step-by-step guidance on setting up the `test/` directory structure with `pass.hcl` and `fail.hcl` files to run `sentinel test`.
* **Multi-Policy Testing:** Guidance on structuring test cases when managing multiple policies (e.g., separate test folders for region restriction vs. instance security).

---

### Phase 3: Terraform Architecture, Encryption & Storage

* **VPC & Digital Sovereignty:** How to design an AWS VPC in Ireland (`eu-west-1`) to meet European data residency standards, network isolation requirements, and compliance frameworks (such as NIS2 and DORA).
* **Enforcing Encryption:** Configuring server-side encryption for EC2 root disks (`root_block_device`) and dedicated database volumes (`aws_ebs_volume`).
* **Storage vs. Compute Dependencies:** Clarifying the relationship between `aws_instance` (CPU/RAM) and `aws_ebs_volume` (SSD storage), and explaining how `aws_volume_attachment` links them at the OS device path level (`/dev/sdh`).
* **Variable Usage:** Line-by-line breakdown of using `size = var.aws_ebs_volume` in `variables.tf` versus hardcoding values.

---

### Phase 4: Single-Region vs. Multi-AZ Deployment Decisions

* **Deployment Complexity Evaluation:** Deciding between a multi-region setup versus a single sovereign region (`eu-west-1`), choosing single-region for clean, readable code and easier testing.
* **Multi-AZ Availability Zone Design:** How Availability Zones (`eu-west-1a`, `eu-west-1b`) operate within a single region, and how to place subnets and web/database instances across AZs to satisfy DORA high-availability requirements.


Chronological list of all prompts and queries regarding Terraform, Sentinel, Digital Sovereignty, and AWS Architecture:

---

### Phase 1: Sentinel Policy Logic & Expression Syntax

1. *Initial prompt on building a beginner-level Terraform and Sentinel project for CA2 focused on Digital Sovereignty, DORA compliance, and secure cloud infrastructure in `eu-west-1`.*
2. **"using helper is more advanced then?"**
3. **"Can all your code recomendations be more beginner level?"**
4. **"thanks! give me an example so I can see if I understand clearly"**
5. **"should I use the http_endpoint?"**

---

### Phase 2: Testing & Sentinel CLI Workflows

6. **"how to test it?"**
7. **"what if I already have a folder for the restric aws region? Can I do another test?"**

---

### Phase 3: AWS Architecture, Sovereignty, Encryption & Storage

8. **"how to configure VPC for dgital sovereignt"**
9. **"How to build resources and policies to enforce encryption?"**
10. **"I don't want to create s3 bucket, but ebs database instead"**
11. **"if I have an ebs, do I need another ec2 instance? I thought using the ebs database was already implied the ec2 instance"**
12. **"okay, can you show me the code of both instances, the web and database server?"**
13. **"why do I need this block inside the web instance? Enforce Root Disk Encryption `root_block_device { encrypted = true }`"**

---

### Phase 4: Terraform Code Structure & HCL Syntax

14. **"what does it mean? `size = var.aws_ebs_volume`"**
15. **"is this more advanced or beginner?"**
16. **"explain, line by line: `resource "aws_volume_attachment" "db-attach" { device_name = "/dev/sdh" volume_id = aws_ebs_volume.database.id instance_id = aws_instance.db-server.id }`"**

---

### Phase 5: Regional Scope & Availability Zone Strategy

17. **"should I write my code to deploy to 2 regions? I am thinking about DORA and sovereign and always provide CDN, but my code seems to be complex"**
18. **"now that I am deploying only to one region, how it works with the AZ?"**
19. **"how can I configure multi-Az?"**




## References

Amazon Web Services (2026) *Configure instance metadata options for new instances*. Available at: [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html) (Accessed: 14 November 2026).

HashiCorp (2026) *aws_ec2_instance_metadata_defaults - Terraform Registry*. Available at: [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_metadata_defaults](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_metadata_defaults) (Accessed: 14 November 2026).

HashiCorp (2026) *aws_vpc - Terraform Registry*. Available at: [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) (Accessed: 15 November 2026).

HashiCorp (2026) *Create infrastructure*. Available at: [https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create) (Accessed: 11 November 2026).

HashiCorp (2026) *Rules*. Available at: [https://developer.hashicorp.com/sentinel/docs/language/rules](https://developer.hashicorp.com/sentinel/docs/language/rules) (Accessed: 14 November 2026).

HashiCorp (2026) *tfplan/v2 Import*. Available at: [https://developer.hashicorp.com/sentinel/docs/features/terraform/tfplan-v2](https://developer.hashicorp.com/sentinel/docs/features/terraform/tfplan-v2) (Accessed: 14 November 2026).

HashiCorp (2026) *Upload your Sentinel policy set to HCP Terraform*. Available at: [https://developer.hashicorp.com/terraform/tutorials/policy/sentinel-cloud-integration](https://developer.hashicorp.com/terraform/tutorials/policy/sentinel-cloud-integration) (Accessed: 10 November 2026).


