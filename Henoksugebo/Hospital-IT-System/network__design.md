# README – network_design.md

## 📄 File Overview
This document provides a comprehensive network architecture blueprint for a mid-sized hospital IT environment. It is intended for system administrators, network engineers, and IT managers involved in designing or auditing healthcare infrastructure.

## 🎯 Purpose
- Serve as the **single source of truth** for the hospital’s logical and physical network layout.
- Ensure the design meets **HIPAA compliance**, high availability, and scalability requirements.

## 🗂️ What’s Inside
- **Topology Diagram** – Detailed description (and reference to the actual diagram file) showing core, distribution, and access layers.
- **VLAN Segmentation** – Separate VLANs for:
  - Medical devices (MRI, PACS)
  - Clinical workstations
  - Guest Wi-Fi
  - VoIP
  - Management network
- **IP Addressing Scheme** – Subnet allocations, reserved ranges, and DHCP scopes for each VLAN.
- **Hardware Specifications** – Firewalls (FortiGate), core switches (Cisco Catalyst), wireless controllers, and access points.
- **Redundancy & Failover** – HSRP/VRRP configuration for routers, redundant power, and ISP links.
- **Security Zones** – DMZ for public-facing services (patient portal), internal secure zone for EHR databases, and network access control (NAC) policies.
- **External Connections** – VPN tunnels to remote clinics and cloud healthcare services (Azure HIPAA environment).

## 🔗 Related Files
- `security_checklist.md` – security controls aligned with this design.
- `deployment_steps.md` – step-by-step implementation of this network.

## 👤 Intended Audience
- Network administrators
- Security auditors
- Hospital IT leadership

## ✅ Usage
Review this document before any network expansion, hardware refresh, or compliance audit. It should be updated whenever a new medical device class is introduced or a subnet is added.