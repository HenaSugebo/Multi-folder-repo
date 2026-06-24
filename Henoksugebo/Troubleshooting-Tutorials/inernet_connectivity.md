# README – internet_connectivity.md

## 📄 File Overview
A comprehensive troubleshooting guide for resolving internet and local network connectivity issues on Windows and macOS endpoints, aimed at helpdesk and support technicians.

## 🎯 Purpose
- Empower support teams to handle **~70% of connectivity tickets** without network admin involvement.
- Provide a consistent, logical flow from physical layer up to application.

## 🌐 Troubleshooting Flow (OSI‑based)
1. **Physical Layer**
   - Check cable connection, link lights, Wi‑Fi switch
   - Verify aeroplane mode is off
2. **Data Link / Network Layer**
   - `ipconfig /all` / `ifconfig` – check for APIPA (169.254.x.x)
   - Release/renew DHCP
   - Flush DNS cache and check hosts file
   - Ping default gateway, 8.8.8.8, DNS server
3. **Wi‑Fi Specific**
   - Signal strength and channel interference
   - Forget and reconnect to SSID
   - WPA2‑Enterprise authentication failures (certificate expired, RADIUS issue)
4. **VPN Issues**
   - Client authentication errors
   - Split‑tunnel configuration verification
   - MTU size adjustments
5. **Browser / Application Connectivity**
   - Proxy settings (PAC file, manual proxy)
   - Firewall/antivirus blocking
   - Test with different browsers, clear SSL state

## 📊 Diagnostic Commands Cheat Sheet
- **Windows**: `netsh wlan show wlanreport`, `tracert`, `nslookup`, `Test-NetConnection`
- **macOS**: `networksetup -listallhardwareports`, `scutil --dns`, `route get`

## 🧪 Scenario‑Based Examples
Includes real‑world scenarios:
- “No internet after sleep mode” – power management on network adapter.
- “Connected but no internet” – DNS misconfiguration or captive portal detection.

## 🔗 Related Files
- `printer_issues.md` – network printers often flagged as “offline” due to same root causes.
- `hardware_upgrade.md` – steps to replace a faulty network card.