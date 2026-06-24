# README – integration_steps.md

## 📄 File Overview
A technical implementation manual for integrating the new ERP system with existing enterprise applications and identity providers.

## 🎯 Purpose
- Provide **detailed configuration instructions** for middleware, APIs, and identity synchronisation.
- Reduce dependency on vendor support by capturing internal step‑by‑step knowledge.

## 🔌 Integration Scenarios Covered
1. **Identity & Access Management**
   - Azure AD Connect / Okta configuration to sync users and groups.
   - Single Sign‑On (SAML 2.0) setup between IdP and ERP.
   - Role mapping: ERP security roles tied to AD group membership.
2. **HR System Sync**
   - Scheduled CSV/API feed from HRIS to ERP employee master.
   - Handling employee status changes (new hires, terminations) in near real‑time.
3. **CRM ↔ ERP**
   - Bi‑directional sync of customer accounts and sales orders.
   - Middleware setup (MuleSoft / Azure Logic Apps) with error handling and retry logic.
4. **Financial Data Import**
   - Integration with legacy accounting for opening balances.
   - Bank statement import format and automation (SFTP).
5. **Email & Notifications**
   - SMTP relay configuration and whitelisting.
   - Template customisation for PO approvals and invoice alerts.

## 📑 Document Format
Each integration includes:
- **Prerequisites** (licences, network ports, service accounts)
- **Configuration Steps** with screenshots/command snippets
- **Validation Tests** (e.g., create a test user in AD, verify it appears in ERP)
- **Troubleshooting quick‑fixes** (common errors and their solutions)

## 🔗 Related Files
- `erp_overview.md` – provides the business context.
- `troubleshooting.md` – handles issues that may arise after integration.