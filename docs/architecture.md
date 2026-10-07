# Architecture

## Sites

| | Site A (Accra) | Site B (London) |
| --- | --- | --- |
| Router | OpenWrt (VM in UTM, later GL.iNet hardware) | OpenWrt (VM or GL.iNet hardware) |
| LAN range | `10.10.0.0/16` | `10.20.0.0/16` |
| VPN address | `10.99.0.1/24` | `10.99.0.2/24` |

Using different ranges at each site is required: WireGuard cannot route between two sites that both use `192.168.1.0/24`.

## Segments (VLANs)

| Segment | VLAN ID | Site A subnet | Site B subnet | Can reach |
| --- | --- | --- | --- | --- |
| Staff | 10 | `10.10.10.0/24` | `10.20.10.0/24` | Internet, other site's Staff, SIEM |
| Guest | 20 | `10.10.20.0/24` | `10.20.20.0/24` | Internet only |
| IoT | 30 | `10.10.30.0/24` | `10.20.30.0/24` | Internet only (restricted ports) |
| Management | 99 | `10.10.99.0/24` | `10.20.99.0/24` | Router admin, SIEM |

## Firewall policy (both sites)

| From → To | Staff | Guest | IoT | Mgmt | Internet | VPN |
| --- | --- | --- | --- | --- | --- | --- |
| Staff | ✅ | ❌ | ✅ (printing) | ❌ | ✅ | ✅ |
| Guest | ❌ | ✅ (isolated clients) | ❌ | ❌ | ✅ | ❌ |
| IoT | ❌ | ❌ | ✅ | ❌ | limited | ❌ |
| Mgmt | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

## Monitoring

- Wazuh manager: _where it runs (Mac Mini container or cloud VM)_
- Each router sends syslog to Wazuh over the VPN.
- Dashboards: blocked connections, failed logins, new DHCP leases (new devices), DNS blocks.

## Decisions log

| Date | Decision | Why |
| --- | --- | --- |
| 2026-10-07 | Start with OpenWrt VMs, buy hardware later | Free to start; proves the design first |
