# Two-Site SOHO

A secured, monitored small office/home office (SOHO) network built across two sites, **Accra** and **London**, linked by a WireGuard VPN, watched by one SIEM, attacked by its own builders, and documented as a free security playbook for small businesses.

> Status: 🚧 Week 0 — setting up. See the [project board](../../projects) for progress.

## Why this project

Most SOHO security write-ups stop at "I configured a firewall." This one:

- runs across **two countries** as one network,
- is **tested under attack** by the people who built it,
- reports results in **numbers** (attacks blocked, detected, fixed), and
- ends with a **playbook** real small businesses can follow.

## Architecture

```
        Site A: Accra                                 Site B: London
 ┌──────────────────────────┐                  ┌──────────────────────────┐
 │      OpenWrt router      │◄── WireGuard ───►│      OpenWrt router      │
 │  firewall · DNS filter   │       VPN        │  firewall · DNS filter   │
 ├────────┬────────┬────────┤                  ├────────┬────────┬────────┤
 │ Staff  │ Guest  │  IoT   │                  │ Staff  │ Guest  │  IoT   │
 └────┬───┴────────┴────────┘                  └────┬───┴────────┴────────┘
      │ logs                                        │ logs
      └──────────────────►  Wazuh SIEM  ◄───────────┘
```

Guest and IoT segments are blocked from Staff at both sites. Full details: [docs/architecture.md](docs/architecture.md).

## Repository layout

| Path | What lives there |
| --- | --- |
| `docs/` | Architecture, team, ground rules, weekly log |
| `site-a-accra/` | Accra router config (sanitised), VLAN plan, build notes |
| `site-b-london/` | London router config (sanitised), VLAN plan, build notes |
| `vpn/` | WireGuard design and example configs (placeholders only) |
| `monitoring/` | Wazuh setup, dashboards, custom rules |
| `attacks/` | Attack log and one write-up per attack |
| `playbook/` | The SOHO Security Playbook for small businesses |
| `scripts/` | Helper scripts (task board setup, sanitising configs) |

## Results

| Metric | Value |
| --- | --- |
| Attacks attempted | — |
| Blocked | — |
| Detected | — |
| Fixed after testing | — |

Filled in during weeks 5–6. Every row links to its write-up in [`attacks/`](attacks/).

## Team

| | Location | Focus |
| --- | --- | --- |
| Kwaku | Accra, Ghana | Site A, monitoring, playbook |
| Emmanuel | London, UK | Site B, DNS filtering, publishing |

## Ethics and scope

We only test equipment we own. No third-party system is touched without signed written permission. See [SECURITY.md](SECURITY.md) and [docs/ground-rules.md](docs/ground-rules.md).

## Licence

Code and configs: MIT. Playbook text: CC BY 4.0. See [LICENSE](LICENSE).
