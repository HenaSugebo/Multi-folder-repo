Here is a detailed work sample that showcases the creation and real-world impact of your **IT support scripts** and **troubleshooting tutorials** —the exact artifacts you listed in your repository. It is written from the perspective of a System Administrator & IT Support Officer who led a service improvement initiative.

---

# WORK SAMPLE

## Project Title: IT Support Automation & Knowledge Base Initiative  
**Role:** IT Support Officer (with System Administration responsibilities)  
**Duration:** Ongoing (initial development: 8 weeks, continuously updated)  
**Environment:** Windows 10/11, Windows Server 2019, Ubuntu 20.04/22.04, Active Directory, PowerShell, Bash, Python, Jira Service Management, SharePoint  
**Repository:** `IT-Support-Scripts/` & `Troubleshooting-Tutorials/`

---

### 1. Context & Problem Statement

At GlobalTrade Logistics, the IT support team of 8 handled an average of 500 tickets per month for 200+ users. A ticket analysis revealed three critical pain points:

- **Repetitive manual tasks** consumed 30% of helpdesk time: user onboarding (account creation, home folder setup), pre-repair data backups, and daily server health checks.
- **Inconsistent troubleshooting** led to wide variations in resolution time. New hires took weeks to become productive because no standard reference existed for common issues.
- **Lack of documentation** meant that when a specialist left, critical knowledge left with them. Tribal knowledge caused escalations for simple printer jams or Wi‑Fi disconnections.

I proposed and led the **“Support Automation & Knowledge Base Initiative”** to solve these problems with two concrete deliverables: a library of **reusable scripts** and a set of **step‑by‑step troubleshooting tutorials** stored in version-controlled GitHub repositories for transparency and portability.

---

### 2. IT Support Scripts (`IT-Support-Scripts/`)

I authored, tested, and deployed three core scripts that addressed the highest-volume, most time-consuming manual tasks. All scripts include built‑in help, robust error handling, and logging to simplify auditing and debugging.

#### a. `backup.ps1` – Pre‑Repair User Data Backup
**Problem:** Before re‑imaging a faulty laptop or performing a hard drive replacement, technicians manually copied Desktop, Documents, and browser bookmarks to a network share. This took 15–20 minutes per machine and occasionally missed critical folders (e.g., Outlook signatures, custom application data).

**Solution:** A PowerShell script that:
- Detects the current logged‑in user (even if the technician is using a local admin account).
- Backs up the entire user profile directory, plus Chrome/Edge bookmarks, Outlook PSTs, Signatures, and Sticky Notes to a timestamped folder on a departmental NAS (`\\backup\IT-Staging\`).
- Generates a **backup manifest** (log file) with file count, total size, and any permission errors.
- Notifies the technician via pop-up when complete and copies the manifest to the helpdesk ticket as an attachment (via REST API call to Jira).

**Impact:** Backup time reduced from 20 minutes to under 2 minutes of technician interaction (script runs automatically). Zero cases of “missing data” after re-imaging since implementation.

#### b. `monitor.sh` – Linux Server Health Check
**Problem:** The IT support team had no dedicated Linux admin. When an application server (Ubuntu) showed slowness or a web service was unreachable, L2 technicians relied on a senior admin to SSH in and run a flurry of ad‑hoc commands. This created a bottleneck.

**Solution:** A Bash script that can be executed by any technician with sudo privileges. It gathers:
- Uptime, CPU load average, memory usage, disk space (with warning thresholds).
- Status of critical services (Nginx, PostgreSQL, Odoo) using `systemctl`.
- Recent error entries from `journalctl` and disk I/O stats via `iostat`.
- Outputs a colour‑coded text report, and optionally emails it to the support distribution list.
- Includes a “quick mode” (`-q`) for immediate red/green light on the five most critical metrics.

**Impact:** L2 technicians can now independently diagnose 80% of Linux‑related issues. Escalations to the senior admin team dropped by 60%, freeing them for project work.

#### c. `user_management.py` – Bulk Active Directory User Provisioning
**Problem:** Onboarding weeks (when 10–15 new hires joined) required the helpdesk to manually create AD accounts, set group memberships, provision home folders, and assign Office 365 licenses. The process took 25+ minutes per user and was prone to typos.

**Solution:** A Python script that reads a CSV file from HR (columns: FirstName, LastName, Department, Title). It:
- Generates a unique `sAMAccountName` and UPN following company naming convention.
- Creates the user in the correct OU based on department.
- Adds the user to all required security groups (including dynamic groups for share access).
- Creates the home folder with appropriate permissions.
- Triggers a sync to Azure AD (via PowerShell subprocess) and assigns an Office 365 E3 license if available.
- Logs all actions to both a CSV audit trail and the central SIEM.

**Impact:** Bulk onboarding of 15 users now completes in less than 5 minutes of technician preparation (reviewing the CSV and pressing enter). Typos eliminated. The script became a template for other identity automation tasks (terminations, department moves).

All three scripts were peer‑reviewed by the infrastructure team and stored in a shared GitHub repository with a clear README describing parameters, prerequisites, and usage examples.

---

### 3. Troubleshooting Tutorials (`Troubleshooting-Tutorials/`)

I created a trio of structured troubleshooting guides aimed at **Level 1/Level 2 support agents**, designed to be used live while on a call with a user. Each follows the same proven format:

> **Symptom → Quick Fix → In‑Depth Diagnosis → Escalation Point**

This reduces the cognitive load on junior agents and ensures consistency.

#### a. `printer_issues.md`
Covers the most frequent printer tickets: “printer offline”, “poor print quality”, “paper jams”, and “label printer calibration”. Each section includes IP/DHCP checks, spooler restart commands, brand‑specific jam clearance steps, and a driver reinstallation flowchart. Real screenshots of error messages and control panels are embedded.

#### b. `internet_connectivity.md`
A logical, OSI‑model‑based troubleshooting flow: starts with physical checks (cable, Wi‑Fi switch), moves to `ipconfig`/`ifconfig` interpretation (APIPA detection, DHCP issues), DNS tests (`nslookup`, `ping`), proxy configurations, and VPN split‑tunnel verification. Includes a cheat sheet of diagnostic commands for both Windows and macOS.

#### c. `hardware_upgrade.md`
Standardised procedures for common hardware tasks that Level 2 techs are expected to perform: RAM upgrade, HDD‑to‑SSD cloning, PSU replacement, and laptop screen swap. Each procedure is risk‑assessed, lists required tools, and includes annotated photos of the internals of the company’s standard Dell and Lenovo models. This guide drastically reduced incorrect disassembly incidents.

**Integration with Ticketing System:**  
I transformed each tutorial’s quick‑fix steps into **Jira Service Management knowledge base articles**, linked directly from the ticket sidebar. When an agent received a “printer offline” ticket, the suggested article appeared automatically. This reduced “What should I do?” hesitation.

**Self‑Service Portal:**  
I extracted the “Quick Fix” sections from `printer_issues.md` and `internet_connectivity.md` and published them on a SharePoint IT self‑service portal. Users could attempt simple fixes before raising a ticket. In the first quarter, **over 150 tickets were deflected** by users solving issues themselves.

---

### 4. Training & Adoption

To ensure the tools didn’t gather dust:
- I ran a 2‑hour workshop for all support staff, where we walked through each script live and role‑played the tutorials.
- We created a “script of the month” challenge, encouraging technicians to suggest improvements via pull requests on GitHub.
- New hires now complete the troubleshooting tutorials as part of their onboarding, cutting their time‑to‑productivity from 4 weeks to 2 weeks.

---

### 5. Outcomes & Metrics

| Metric | Before Initiative | After Initiative (6 months) |
|--------|-------------------|----------------------------|
| Average user onboarding time (per user) | 25 minutes | 5 minutes (review & run) |
| Server health check escalation rate | 100% (to senior admin) | 20% |
| First‑contact resolution for printer tickets | 35% | 68% |
| Internet connectivity tickets resolved without escalation | 40% | 75% |
| Time to onboard a new support agent (to independent) | 4 weeks | 2 weeks |
| IT knowledge base articles linked to tickets | 5 | 42 (and growing) |

Most importantly, the team’s morale improved: technicians felt empowered, not helpless, and the shift‑left in resolution freed the senior engineers to work on the major projects (like the ERP deployment) that my work samples elsewhere describe.

---

### 6. Personal Reflection & Skills Demonstrated

This initiative was not about writing perfect code—it was about understanding the **day‑to‑day friction** of IT support and systematically removing it. I demonstrated:

- **Scripting & Automation:** PowerShell, Bash, and Python to eliminate repetitive work.
- **Documentation Excellence:** Creating clear, visual, step‑by‑step guides that follow adult learning principles.
- **IT Service Management Thinking:** Aligning every script and tutorial with a ticket category, a resolution metric, and a knowledge article—embedding them into the ITIL workflow.
- **Knowledge Sharing Culture:** Moving from “tribal knowledge” to a public GitHub repository that became a living asset for the entire IT department.

The `IT-Support-Scripts/` and `Troubleshooting-Tutorials/` repositories are a permanent, evolving part of my professional portfolio, and I continue to apply the same documentation‑first philosophy to every system I touch.

---

*This work sample illustrates the proactive, service‑oriented mindset I bring as a System Administrator and IT Support Officer: finding root causes, building reusable tools, and empowering the entire support ecosystem.*
