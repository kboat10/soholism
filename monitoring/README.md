# Monitoring (Wazuh)

## Where it runs

_Fill in:_ Mac Mini container (check the Wazuh Docker images support ARM64 for your version) or a small cloud VM (4 GB RAM minimum is comfortable).

## What it collects

| Source | How | What we watch for |
| --- | --- | --- |
| Site A router | syslog over VPN → Wazuh | Firewall drops, admin logins, new DHCP leases |
| Site B router | syslog over VPN → Wazuh | Same |
| DNS filter (AdGuard Home / Pi-hole) | query log | Blocked malicious domains |
| Test laptops | Wazuh agent | Logins, new processes, file changes |

## OpenWrt → syslog

```sh
uci set system.@system[0].log_ip='<WAZUH_VPN_IP>'
uci set system.@system[0].log_port='514'
uci set system.@system[0].log_proto='udp'
uci commit system && /etc/init.d/log restart
```

## Custom rules

Put any Wazuh rules you write in `rules/`, one file per detection, with a comment saying which attack in `attacks/` it catches.

## Dashboards

Screenshot each dashboard into `screenshots/` once it shows real data.
