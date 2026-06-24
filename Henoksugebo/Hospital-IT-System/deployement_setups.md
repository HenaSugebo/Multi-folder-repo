# README – deployment_steps.md

## 📄 File Overview
A step‑by‑step implementation guide for deploying the hospital’s core IT infrastructure, from bare‑metal server setup to live production handover.

## 🎯 Purpose
- Serve as a **repeatable runbook** for the initial build‑out or disaster recovery rebuild.
- Ensure consistency across multiple deployments (e.g., primary site, disaster recovery site).

## 🧱 Structure
The document is organized chronologically:

1. **Pre‑Deployment Preparation**
   - Rack and stack hardware
   - Cable labeling and power verification
   - Firmware baseline check (BIOS, iDRAC/iLO, switch OS)
2. **Network Foundation**
   - Configure management IPs on switches & firewalls
   - Set up VLANs, trunk ports, and inter‑switch LAGs
   - Apply firewall base policies
3. **Virtualization Layer**
   - Install ESXi / Hyper‑V hosts
   - Join to vCenter / SCVMM
   - Create distributed switch and port groups
4. **Core Services**
   - Build Domain Controllers (Active Directory, DNS, DHCP)
   - Deploy RADIUS/NPS for Wi‑Fi authentication
   - Set up Windows Deployment Services (WDS) for workstation imaging
5. **Storage & Backup**
   - Present SAN LUNs to hosts
   - Configure iSCSI/FC multipath
   - Set up backup software (Veeam) and run first full backup
6. **Clinical Applications**
   - Install EHR application servers (clustered)
   - Configure HL7 interfaces and integration engine
   - Validate connectivity with medical devices
7. **Security Hardening**
   - Apply GPOs per security checklist
   - Enable BitLocker on all servers
   - Set up privileged access workstations (PAW)
8. **Validation & Go‑Live**
   - Execute test scripts for each clinical workflow
   - Perform failover tests (link, host, and site)
   - Final sign‑off by IT director

## ⚠️ Important Notes
- Steps include **expected duration** and **responsible role** for each task.
- Where possible, PowerShell/CLI commands are provided inline.
- Rollback instructions are noted for critical steps.

## 🔗 Related Files
- `network_design.md` – reference for IP/VLAN details.
- `security_checklist.md` – hardening steps are derived from this.