# README – security_checklist.md

## 📄 File Overview
A practical, itemized security checklist tailored for a hospital IT environment. It translates regulatory requirements (HIPAA, HITECH) into actionable technical controls.

## 🎯 Purpose
- Enable **auditors and system admins** to verify that all critical security measures are in place.
- Act as a **pre‑audit self‑assessment** tool before official compliance checks.

## 📋 Checklist Structure
1. **Access Control**
   - MFA enforced for all EHR/EPR systems.
   - Role-based access control (RBAC) for Active Directory groups.
   - Regular user access reviews (quarterly).
2. **Network Security**
   - Firewall rules reviewed and validated against least-privilege principle.
   - VLAN isolation confirmed – medical devices cannot reach guest network.
   - Intrusion Prevention System (IPS) signatures up to date.
3. **Endpoint Protection**
   - All clinical workstations running EDR solution with real-time scanning.
   - USB ports locked down via GPO (except for encrypted hospital drives).
   - Full-disk encryption (BitLocker) enabled.
4. **Data Protection**
   - Database encryption at rest and in transit for patient records.
   - Backup encryption and off‑site replication verified.
   - DLP policies blocking upload of PHI to unauthorized cloud storage.
5. **Logging & Monitoring**
   - SIEM collecting logs from firewalls, servers, and EHR applications.
   - Alert rules for 5 failed login attempts, lateral movement, data exfiltration.
   - Log retention set to minimum 6 years.
6. **Physical Security**
   - Server room access controlled by badge + biometrics.
   - CCTV coverage and environmental monitoring in data closets.
7. **Vendor & Third-party**
   - Business Associate Agreements (BAA) signed with all cloud providers.
   - Remote vendor access restricted to jump hosts with session recording.

## 🔄 Maintenance
Checklist must be reviewed and updated **bi‑annually**, or after any major system change. Each item includes a “status” field ( ✅ / ❌ ) and a “comments” column for evidence or mitigation notes.

## 🔗 Related Files
- `network_design.md` – defines the network controls referenced here.
- `deployment_steps.md` – implementation steps for several security configurations.