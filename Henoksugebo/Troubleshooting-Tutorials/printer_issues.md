# README – printer_issues.md

## 📄 File Overview
A user‑friendly, step‑by‑step tutorial designed for **IT support staff and helpdesk agents** to quickly diagnose and fix common printer problems in an enterprise environment.

## 🎯 Purpose
- Serve as **on‑the‑spot reference** during a live support call.
- Reduce escalation of simple issues to desktop support or engineering.

## 🖨️ Covered Topics
1. **Printer Offline**
   - Checking network connectivity (ping, IP config)
   - Restarting print spooler service
   - Clearing stuck print jobs
   - Re‑adding printer via IP address
2. **Poor Print Quality**
   - Cartridge/Toner issues, cleaning cycles
   - Print head alignment (local USB printers)
   - Updating drivers
3. **Paper Jams**
   - Safe jam removal procedures for major brands (HP, Brother, Canon)
   - Sensor cleaning to prevent recurring jams
4. **Print Server Issues**
   - Verifying print server queue status
   - Migrating printers between servers
   - Group Policy printer deployment troubleshooting
5. **Specialty Printers (Label, Receipt)**
   - Calibration steps
   - Correct media setting in driver

## 📋 Format
Each issue includes:
- **Symptom** – how the user describes it
- **Quick Fix** – 2‑minute attempted resolution
- **In‑Depth Diagnosis** – logs to check (Event Viewer, print server logs)
- **Escalation Point** – when to hand over to network/server team

## 🔗 Related Files
- `internet_connectivity.md` – often a root cause for network printer “offline” status.
- `hardware_upgrade.md` – guidance on adding/replacing printer hardware.