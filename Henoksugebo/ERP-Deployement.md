Here is a detailed work sample focused on **ERP deployment, system design, and configuration**, written from the perspective of a System Administrator & IT Support Officer. It mirrors the style of the previous hospital IT work sample and draws directly from the GitHub repository structure you shared.

---

# WORK SAMPLE

## Project Title: On‑Premises ERP Deployment with Hybrid Identity Integration
**Role:** System Administrator & IT Support Officer  
**Duration:** 12 weeks (Planning → Hyper‑Care)  
**Environment:** Ubuntu 22.04 LTS, PostgreSQL, Nginx, Windows Server 2022, VMware vSphere, Azure AD Connect, Veeam Backup, Zabbix  
**Repository:** `ERP-Deployment-Guide/`

---

### 1. Context & Business Problem

GlobalTrade Logistics, a mid‑sized freight forwarding company with 200+ employees, was struggling with fragmented legacy tools: separate systems for accounting, CRM, and HR, none of which communicated. Data duplication, manual report generation, and lack of a single customer view were causing delays in order processing and financial close.

I was brought in as the **System Administrator** to own the entire IT infrastructure side of an ERP implementation. The business selected **Odoo 16** (on‑premises) for its flexibility. My mission was to:
- Design a resilient, secure server architecture that could scale.
- Deploy and configure the ERP application from the ground up.
- Integrate it seamlessly with the existing Active Directory for authentication, and with Office 365 for email.
- Produce runbook-quality documentation that would make the support team self-sufficient after go‑live.

---

### 2. System Design & Architecture

I started by documenting the high‑level business case and technical architecture in `erp_overview.md` to align IT and stakeholders. Then I translated that into a concrete server and network design.

**Key architectural decisions:**

- **Three‑Tier Separation:**
  - **Web Tier (2 VMs):** Nginx reverse proxies placed in a DMZ VLAN, handling SSL termination and serving static assets.
  - **Application Tier (2 VMs):** Odoo application servers behind a load balancer (Nginx upstream). Connected to the internal server VLAN.
  - **Data Tier (2 VMs):** PostgreSQL 15 primary + hot standby with streaming replication. Database volumes stored on an iSCSI SAN for snapshot‑based recovery.
- **High Availability:**
  - App servers in an active‑active pair. PostgreSQL in active‑passive with automatic failover controlled by `repmgr`. Nginx servers clustered via keepalived (VRRP) for a floating virtual IP.
- **Network Segmentation:**
  - ERP components placed in VLAN 50 (ERP), isolated from general corporate LAN by a FortiGate firewall. Only the Nginx DMZ interface could be reached from user subnets on port 443.
- **Backup Strategy:**
  - Nightly `pg_dump` of the database, compressed and encrypted.
  - Veeam Agent for Linux capturing app server files (filestore, configuration).
  - Backups replicated off‑site to Azure Blob Storage with immutable retention for 30 days.

I created a detailed **architecture diagram** (referenced in `erp_overview.md`), along with a table of IP assignments, hostnames, and firewall rules.

---

### 3. Deployment & Configuration

All step‑by‑step procedures were captured in `integration_steps.md`. Below are the highlights of what I configured personally.

**Operating System & Platform:**
- Provisioned six Ubuntu 22.04 VMs on our VMware vSphere cluster using a hardened template (CIS benchmark applied).
- Used **Ansible playbooks** to automate common post‑install tasks: package updates, NTP, firewall (ufw), and Zabbix agent installation.

**ERP Application Setup:**
- Cloned Odoo 16 from the official GitHub repository, set up a dedicated system user, and created a Python virtual environment.
- Configured the `odoo.conf` file with:
  - Database connection string pointing to the PostgreSQL primary.
  - Session storage in Redis for shared sessions across the two app servers.
  - Workers and memory limits tuned for 200 concurrent users (8 workers, 4 GB per VM).
- Created `systemd` unit files to run Odoo as a service with automatic restart.

**Web & SSL:**
- Installed Nginx, configured reverse proxy to pass requests to the Odoo upstream. Applied rate limiting and WAF rules (ModSecurity) for the login page.
- Automated SSL certificate management with **Let's Encrypt** and Certbot, with a cron job for renewal.

**Identity Integration (Hybrid):**
- **On‑prem Active Directory** was the source of truth. I installed `libldap` and configured Odoo’s LDAP auth module to bind to a read‑only domain controller.
- Mapped AD attributes (`sAMAccountName`, `mail`, `memberOf`) to Odoo users, enabling automatic role assignment based on security groups (e.g., `ERP_Manager`, `ERP_Finance`).
- For remote users (sales team), I configured **SAML 2.0 SSO** using **Azure AD** as the Identity Provider. This required configuring a relying party trust in Azure AD and an XML metadata exchange with Odoo—all documented step‑by‑step in `integration_steps.md`.

**Email & Notifications:**
- Odoo’s outgoing mail was routed through the company’s **Office 365 SMTP relay** (authenticated connector), ensuring emails did not get flagged as spam.
- Inbound mail for support tickets was set up using a shared mailbox and a fetchmail script (with a secure app password).

**Monitoring:**
- Custom Zabbix templates monitored Odoo process health, PostgreSQL replication lag, Nginx active connections, and SSL certificate expiry. Added a trigger that would page on‑call if replication lag exceeded 30 seconds.

**Backup Verification:**
- After configuration, I performed a full restore drill: rebuilt the app server from Veeam backups and restored the PostgreSQL database onto a clean VM. The ERP was fully functional within 45 minutes—well within the 4‑hour RTO.

---

### 4. Documentation & Knowledge Transfer

I strongly believe that a project is only successful if the operations team can support it independently. I created three documents that live in the `ERP-Deployment-Guide/` folder of my GitHub:

- **`erp_overview.md`** – A non‑technical executive summary and a technical architecture reference. Used to onboard new team members.
- **`integration_steps.md`** – A 28‑page runbook with exact commands, screenshots of configuration pages, and expected outputs. Covers everything from OS setup to LDAP and email integration.
- **`troubleshooting.md`** – A living document seeded with the 10 most common issues I predicted (e.g., “LDAP authentication failure”, “report PDF not generating”, “slow performance on order screen”). Each includes diagnostic commands and resolution steps. Post‑go‑live, the support team added five more issues themselves.

I also held a 3‑hour handover workshop with the Level 1/2 support team, walking them through the troubleshooting guide and showing them how to perform a manual failover of the database if automation ever failed.

---

### 5. Testing & Go‑Live

- **Load Testing:** Simulated 150 concurrent users with `locust.io`, measuring response times for the most used views (sales orders, inventory). Fine‑tuned PostgreSQL `shared_buffers` and Odoo workers to keep 95th percentile response time under 2 seconds.
- **Security Validation:** Ran an internal Nessus scan against the ERP VLAN. Fixed one information disclosure (server version in HTTP headers) before go‑live.
- **Data Migration:** Collaborated with the data team to import 50,000 records (accounts, customers, open invoices) from CSV files generated by the legacy system. I provided the Linux server environment for the import scripts, monitored resource usage, and resolved a memory exhaustion issue by adding swap and staging the import in batches.
- **Cutover:** Switched users to the new ERP over a weekend. Ran the old system in read‑only mode for one week as a safety net. There were **zero critical tickets** in the first 48 hours.

---

### 6. Outcome & Reflection

- **Performance:** ERP response time was 40% faster than the legacy system, with 99.85% uptime in the first quarter.
- **Support Efficiency:** The `troubleshooting.md` guide allowed Level 1 to resolve 65% of post‑go‑live tickets directly, up from an expected 30% for a new system.
- **Security:** Passed internal audit; the hybrid LDAP/SAML configuration was praised for giving granular access control without frustrating users with multiple logins.
- **Personal Growth:** This project solidified my ability to design a system end‑to‑end—not just “install an app.” It required thinking about networking, identity, backup, monitoring, and the human factor of documentation. The artifacts I produced (`erp_overview.md`, `integration_steps.md`, `troubleshooting.md`) have since become a template for how I approach every infrastructure project.

---

*This work sample demonstrates my competence in ERP system design, Linux and Windows administration, hybrid identity configuration, and the creation of clear, actionable technical documentation—all through the lens of a System Administrator & IT Support Officer.*