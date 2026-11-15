## Final Limitations & Recommendations

> **Summary:** While the core resources implemented in this assessment fulfilled key learning outcomes and established foundational Infrastructure-as-Code (IaC) competence, specific advanced architectural controls were scoped out due to codebase technical constraints, steep learning curves in Terraform/Sentinel development, and tight project timelines.

---

### Production Readiness & Compliance Gap Analysis

If this architectural design were to be deployed in a production environment, the following implementations must be incorporated to achieve compliance with **European Digital Sovereignty**, **DORA (Digital Operational Resilience Act)**, and **ISO/IEC 27001** requirements:

#### 1. Custom VPC Architecture
* **Implementation:** Transition from the default VPC to a custom VPC topology featuring distinct **Public**, **Private**, and **Database (Isolated)** subnet tiers.
* **Impact:** Eliminates auto-assigning public IP addresses and enforces strict network boundary isolation between internal workloads and the public internet.

#### 2. Multi-Region Redundancy & High Availability
* **Implementation:** Deploy resources across a secondary AWS region within the EU (e.g., `eu-central-1` Frankfurt paired with `eu-west-1` Ireland).
* **Impact:** Satisfies mandatory DORA and ISO high-availability, fault-tolerance, and cross-region disaster recovery requirements.

#### 3. Sovereign Key Management (AWS KMS XKS / CloudHSM)
* **Implementation:** Integrate AWS KMS with an **External Key Store (XKS)** or dedicated **AWS CloudHSM** instances.
* **Impact:** Fulfills strict data sovereignty rules by ensuring encryption keys are generated, stored, and managed strictly on hardware located in Ireland, preventing cloud provider decryption.

#### 4. AWS PrivateLink & Service Endpoints
* **Implementation:** Provision Interface and Gateway VPC Endpoints for core AWS services (Amazon S3, KMS, DynamoDB).
* **Impact:** Ensures internal application traffic remains on the private AWS network backbone without routing over the public internet.

---

### Architectural Requirements Baseline

| Feature / Standard | Current Assessment State | Production Target (DORA / ISO Compliance) |
| :--- | :--- | :--- |
| **Network Isolation** | Default VPC (Flat topology) | Custom VPC (Public, Private, Isolated Subnets) |
| **Resilience & DR** | Single Region (`eu-west-1`) | Multi-Region Active/Standby (`eu-west-1` + `eu-central-1`) |
| **Key Governance** | Provider-managed / Default KMS | Sovereign KMS XKS / On-Prem / CloudHSM |
| **Service Traffic Path** | Internet Gateway routing | AWS PrivateLink & Dedicated VPC Endpoints |

---

> **Conclusion:** The features omitted during this iteration provide a clear roadmap for enterprise production hardening. The implemented baseline successfully established the necessary automation patterns and compliance verification workflows via Sentinel.