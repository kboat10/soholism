#!/usr/bin/env bash
# Create labels and one issue per task for the 8-week plan.
# Usage: bash scripts/create-issues.sh <owner/repo>
# Requires the GitHub CLI, logged in: gh auth login
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <owner/repo>   e.g. $0 accra-london-sec/two-site-soho" >&2
  exit 1
fi
REPO="$1"

label() { gh label create "$1" --repo "$REPO" --color "$2" --description "$3" --force >/dev/null; }

label "week-1" "c5def5" "Lab foundations"
label "week-2" "bfdadc" "Segmentation"
label "week-3" "d4c5f9" "VPN link"
label "week-4" "fef2c0" "Monitoring"
label "week-5-6" "f9d0c4" "Attack and detect"
label "week-7-8" "c2e0c6" "Playbook and publishing"
label "site-a" "0e8a16" "Accra"
label "site-b" "1d76db" "London"
label "both" "5319e7" "Done together"
label "task" "ededed" "Build or write-up work"
label "finding" "d93f0b" "Problem found by an attack"

issue() {
  local title="$1" labels="$2" body="$3"
  gh issue create --repo "$REPO" --title "$title" --label "$labels" --body "$body" >/dev/null
  echo "  + $title"
}

echo "Creating issues in $REPO ..."

# Week 1 — lab foundations
issue "Install OpenWrt VM at Site A" "week-1,site-a,task" "Install OpenWrt (ARM64/armsr image) in UTM on the Mac Mini with two network adapters (WAN + LAN). Set a strong root password, update packages. Notes in site-a-accra/README.md."
issue "Install OpenWrt at Site B" "week-1,site-b,task" "Install OpenWrt in a VM (VirtualBox/UTM/Hyper-V) or on a GL.iNet router. Strong root password, update packages. Notes in site-b-london/README.md."
issue "Add one test client behind each router" "week-1,both,task" "A small Linux VM (e.g. Alpine or Ubuntu Server) on each router's LAN. Confirm it gets an address and reaches the internet."
issue "Agree address plan" "week-1,both,task" "Confirm the 10.10.x / 10.20.x plan in docs/architecture.md, or change it, before anyone builds VLANs."

# Week 2 — segmentation
issue "Create Staff, Guest, IoT and Mgmt segments at Site A" "week-2,site-a,task" "VLANs 10/20/30/99 as in docs/architecture.md. Separate firewall zone per segment."
issue "Create Staff, Guest, IoT and Mgmt segments at Site B" "week-2,site-b,task" "VLANs 10/20/30/99 as in docs/architecture.md. Separate firewall zone per segment."
issue "Write and test firewall rules (both sites)" "week-2,both,task" "Implement the policy table in docs/architecture.md. Test each cell with ping/nc from a client in each segment and record results."
issue "Lock down router admin" "week-2,both,task" "Admin UI and SSH only from Mgmt; SSH keys only; disable WAN access; disable UPnP and WPS."

# Week 3 — VPN
issue "Choose VPN connection method" "week-3,both,task" "Check whether either site can receive inbound UDP 51820 (CGNAT?). Pick direct, cloud relay or Tailscale; record why in docs/architecture.md."
issue "Bring up WireGuard tunnel" "week-3,both,task" "Generate keys on each router, swap public keys only, configure per vpn/examples. Confirm ping 10.99.0.1 <-> 10.99.0.2."
issue "Route Staff-to-Staff across sites only" "week-3,both,task" "Allow Staff A <-> Staff B over the tunnel; block Guest and IoT from the tunnel. Test and record."
issue "Decide on hardware routers" "week-3,both,task" "Stay on VMs or buy GL.iNet routers? Record the decision and cost in docs/architecture.md."

# Week 4 — monitoring
issue "Deploy Wazuh" "week-4,site-a,task" "Run Wazuh (Docker on the Mac Mini if ARM64 images work, else a small cloud VM). Note the setup in monitoring/README.md."
issue "Send router logs to Wazuh" "week-4,both,task" "Configure remote syslog on both routers over the VPN. Confirm events arrive from each site."
issue "Set up DNS filtering" "week-4,site-b,task" "AdGuard Home or Pi-hole for each site's Staff and Guest. Test with a known test domain from your blocklist, not a live malicious site."
issue "Build first dashboards" "week-4,site-a,task" "Blocked connections, failed logins, new devices, DNS blocks. Screenshot into monitoring/screenshots/."

# Weeks 5–6 — attack and detect
issue "London attacks Site A (attacks 01–04)" "week-5-6,site-b,task" "Run attacks 01–04 from attacks/README.md from Kali against Site A only. Write each up from attacks/TEMPLATE.md."
issue "Accra defends Site A and records detections" "week-5-6,site-a,task" "For each attack: blocked? detected? which alert? Fill the attack log."
issue "Accra attacks Site B (attacks 05–08)" "week-5-6,site-a,task" "Run attacks 05–08 against Site B only. Write each up from attacks/TEMPLATE.md."
issue "London defends Site B and records detections" "week-5-6,site-b,task" "For each attack: blocked? detected? which alert? Fill the attack log."
issue "Fix findings and re-test" "week-5-6,both,task" "Open a 'finding' issue for each gap, fix it, re-run the attack, update the results table in README.md."

# Weeks 7–8 — playbook and publishing
issue "Write the SOHO Security Playbook" "week-7-8,site-a,task" "Fill playbook/README.md sections 1–9 from what we built and found. Plain language, cedis and pounds."
issue "Final README and architecture diagram" "week-7-8,site-b,task" "Results table filled, diagram exported, every attack linked."
issue "Publish the write-up" "week-7-8,site-b,task" "Blog post (GitHub Pages or Medium) and a LinkedIn post each. Link back to the repo."
issue "Optional: real small-business review" "week-7-8,both,task" "Only with signed written permission and scope. Run the playbook checklist and write an anonymised before/after."

echo "Done. Add the issues to your project board: Projects → your board → Add items → select all."
