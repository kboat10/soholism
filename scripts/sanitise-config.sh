#!/usr/bin/env bash
# Strip secrets and identifying values from an OpenWrt/WireGuard config before committing.
# Usage: bash scripts/sanitise-config.sh <input> <output>
# Always read the output yourself before committing: this catches common cases, not all.
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Usage: $0 <input> <output>" >&2
  exit 1
fi

in="$1"; out="$2"

sed -E \
  -e "s/(option (private_key|preshared_key|key|password|psk)[[:space:]]+)'[^']*'/\1'<REDACTED>'/g" \
  -e "s/(PrivateKey|PresharedKey)[[:space:]]*=.*/\1 = <REDACTED>/g" \
  -e "s/([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}/<MAC>/g" \
  -e "s/(option endpoint_host[[:space:]]+)'[^']*'/\1'<PUBLIC_ADDRESS>'/g" \
  -e "s/Endpoint[[:space:]]*=.*/Endpoint = <PUBLIC_ADDRESS>:51820/g" \
  "$in" > "$out"

# Flag any remaining public IPv4 addresses (anything outside private ranges) for manual review
if grep -En '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$out" \
   | grep -Ev '\b(10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[01])\.|127\.|0\.0\.0\.0|255\.)' ; then
  echo "⚠️  Lines above may contain public IP addresses. Review before committing." >&2
fi

echo "Sanitised: $out"
