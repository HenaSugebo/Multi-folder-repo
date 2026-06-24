Here’s a detailed work sample written as a professional project report. It showcases My capabilities as a System Administrator and IT Support Officer through a realistic healthcare IT scenario—pulling together network design, security hardening, scripting, and documentation skills from My profile.

---

# WORK SAMPLE

## Project Title: Design, Security Hardening, and Deployment of a Hospital IT Infrastructure

**Role:** System Administrator & IT Support Officer  
**Duration:** 16 weeks (Discovery → Go-Live)  
**Environment:** Windows Server 2022, Ubuntu Server, VMware vSphere, FortiGate Firewalls, Cisco Switches, Azure AD Connect, Veeam Backup  
**Compliance Framework:** HIPAA / HITECH

---

### 1. Context & Problem Statement

A 120-bed community hospital was expanding into a newly constructed wing and simultaneously migrating from a legacy flat network to a modern, segmented, and HIPAA-compliant infrastructure. The existing setup had no VLAN separation, weak access controls, and no disaster recovery plan. Patient data (EHR) and medical devices coexisted on the same broadcast domain as guest Wi-Fi.

As the **lead System Administrator**, I was tasked with:
- Designing a secure, highly available network that isolates medical devices, clinical workstations, guest users, and management traffic.
- Hardening systems according to HIPAA technical safeguards.
- Creating a detailed deployment runbook that internal IT staff could execute, even under pressure.
- Ensuring the new environment passed a third-party security audit before going live.

---

### 2. Network Design (Logical & Physical)

I produced the `network_design.md` document (stored in `Hospital-IT-System/`) that became the single source of truth for the project. Key design decisions:

- **VLAN Segmentation:**
  - **VLAN 10 – Clinical:** EHR workstations, nursing stations.
  - **VLAN 20 – Medical Devices:** MRI, PACS, infusion pumps (air-gapped from internet, restricted ACLs).
  - **VLAN 30 – Guest Wi-Fi:** Internet-only, client isolation enforced.
  - **VLAN 40 – VoIP:** QoS prioritised.
  - **VLAN 99 – Management:** iDRAC/iLO, switch SSH, backup interfaces.
- **IP Addressing:** /24 subnets per VLAN, DHCP scopes with reservations for critical devices. All static assignments documented in `network_design.md`.
- **Redundancy:** Two FortiGate 200F firewalls in Active-Passive HA; dual Cisco Catalyst 9300 core switches with HSRP for VLAN gateways; dual WAN links with SD-WAN failover.
- **External Access:** Azure AD Connect synced on-prem AD to Azure AD for cloud EHR access. Site-to-site VPN tunnels to three remote clinics using IPSec.

The design document included a topology diagram (referenced in the MD), port mapping tables, and a justification for every architectural choice against HIPAA requirements.

---

### 3. Security Hardening (Translating Compliance into Configuration)

I created `security_checklist.md` as a practical audit tool. I then implemented the controls across the infrastructure:

- **Access Control:**
  - MFA enforced for all clinical applications via Azure AD Conditional Access.
  - RBAC model in Active Directory: groups like `Clinician`, `Radiologist`, `ITAdmin` mapped to least-privilege file share and EHR permissions.
  - Quarterly user access reviews scheduled via PowerShell script sending automated reminders.
- **Network Security:**
  - ACLs on FortiGate: Medical VLAN could only talk to specific EHR server IPs on required ports (e.g., HL7 on TCP 2575).
  - Intrusion Prevention System (IPS) enabled on internal segment with anomaly-based detection for lateral movement attempts.
- **Endpoint Protection:**
  - BitLocker enforced via GPO, recovery keys backed up to AD.
  - USB ports restricted via GPO (only hospital-issued encrypted drives allowed).
  - Windows LAPS deployed to rotate local admin passwords automatically.
- **Audit Logging:**
  - Centralized logs from firewalls, switches, Windows Event Logs, and EHR app into a SIEM (Microsoft Sentinel). Designed alerts for: 5 failed login attempts, addition to Domain Admins group, firewall rule modifications.

The security checklist was used during the pre-audit walkthrough. **Result:** zero critical findings from the external auditor.

---

### 4. Deployment & Automation

The implementation was guided by `deployment_steps.md`—a 42-page runbook I authored. It broke down the entire build into numbered, time-estimated tasks with PowerShell commands where possible. Example snippet from the runbook:

```powershell
# Step 17: Create VLAN 10 on both core switches via SSH
New-Vlan -VlanId 10 -Name "Clinical"
Set-Vlan -VlanId 10 -IpAddress 10.10.10.2 -SubnetMask 255.255.255.0
Enable-HSRP -Group 1 -VirtualIp 10.10.10.1 -Priority 110
```

Key actions I personally performed:
- Built 4 VMware ESXi hosts, configured iSCSI storage, and created a Windows Server 2022 template.
- Promoted two Domain Controllers, deployed DHCP failover, and migrated 300 user objects from the old domain.
- Set up Veeam Backup & Replication with daily VM backups and off-site copy to Azure Blob (immutable).
- Used my `user_management.py` script (from the GitHub repo) to bulk-create clinical user accounts from an HR-provided CSV, automatically assigning correct OUs and security groups.
- Ran disaster recovery drill: failed over a DC and the EHR application server to a cold standby host. Achieved **RTO of 1h 45min** and **RPO of 15 minutes** (log shipping).

---

### 5. IT Support & Knowledge Transfer

As an IT Support Officer, I knew the hospital's helpdesk needed to be self-sufficient after the project. I:
- Delivered a 2-hour hands-on workshop for 6 support technicians, walking through the `Troubleshooting-Tutorials/` guides (printer issues, Wi-Fi, hardware upgrades) I had created.
- Populated their ServiceNow instance with the `troubleshooting.md` from the ERP guide adapted for hospital systems (e.g., “EHR not loading” mapped to DNS/DHCP checks).
- Documented every device’s MAC address, port assignment, and warranty in a central asset register.

In the first month post-go-live, **Level 1 resolution rate rose from 40% to 72%**, directly attributable to the self-service portal and the new knowledge base.

---

### 6. Outcome & Lessons Learned

- **Uptime:** 99.95% over the first six months (only one planned maintenance window).
- **Security:** Passed HIPAA technical audit on first attempt, saving the hospital an estimated $40,000 in remediation costs.
- **Business Continuity:** DR plan validated and now tested semi-annually.
- **Personal Takeaway:** The biggest success factor was **documentation-first thinking**. Writing `deployment_steps.md` before racking a single server forced me to think through dependencies and catch gaps (like a missing storage VLAN) early. This approach has become my default methodology for every project, whether it’s an ERP integration or a simple hardware upgrade.

---

*This work sample represents a synthesis of my skills as a System Administrator and IT Support professional: designing secure, compliant systems, executing complex deployments, and empowering end-user support teams through clear documentation and knowledge sharing.*