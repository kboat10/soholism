# WireGuard site-to-site VPN

## Design

| | Site A (Accra) | Site B (London) |
| --- | --- | --- |
| Tunnel address | `10.99.0.1/24` | `10.99.0.2/24` |
| Routes to other site | `10.20.0.0/16` | `10.10.0.0/16` |
| Listens on | UDP 51820 | UDP 51820 |

## Reaching each other

Home internet usually has no fixed public IP and may sit behind carrier-grade NAT (common on mobile and some fibre in Ghana). Options, simplest first:

1. **One side reachable:** if one site can forward UDP 51820, the other connects to it with `PersistentKeepalive = 25`.
2. **Small cloud relay:** a cheap VM acts as a hub; both sites connect out to it.
3. **Tailscale:** WireGuard-based and handles NAT for you. Fine as a fallback, but write up why you used it.

Record which you chose, and why, in `docs/architecture.md`.

## Keys

Generate on each router, never on a shared machine:

```sh
wg genkey | tee privatekey | wg pubkey > publickey
```

Share **only** public keys (they're safe). Private keys stay on the router and in your password manager. `.gitignore` blocks `wg*.conf` and `*privatekey*`.

See `examples/` for configs with placeholder values.
