# Server — Mac Mini (Late 2012)

Home server running NixOS, used for self-hosted services, file sync, and VPN gateway.

## Hardware

### Processor (CPU)

| Property | Value |
|---|---|
| Model | Intel Core i7-3720QM (Ivy Bridge) |
| Cores / Threads | 4 Physical / 8 Logical |
| Clock Speed | 2.60 GHz base / 3.60 GHz turbo |
| L3 Cache | 6 MB |
| Architecture | x86_64 |

### Memory (RAM)

| Property | Value |
|---|---|
| Total | 16 GB (15 GiB reported by OS) |
| Configuration | 2 × 8 GB, Dual Channel |
| Swap | 15 GB partition |

### Storage

| Property | Value |
|---|---|
| Drive | 250 GB SSD |
| `/boot` | 512 MB (EFI) |
| `[SWAP]` | 15 GB |
| `/` | ~218 GB (root, Nix store, user data) |

### Capabilities

- **Virtualization:** VT-x enabled — Docker and KVM ready
- **Encryption:** AES-NI support — efficient WireGuard/VPN throughput
- **Security mitigations:** NixOS kernel mitigations applied (Spectre, Meltdown, L1TF)

## NixOS configuration

**Hostname:** `myServer`
**Channel:** `nixos-unstable`
**State version:** `25.11`

### Modules loaded

| Module | Purpose |
|---|---|
| `modules/common.nix` | Base system settings (boot, locale, nix GC) |
| `modules/utility/shell_aliases.nix` | Shell aliases |
| `modules/server/apps.nix` | CLI tools (kitty, git) |
| `modules/server/ssh.nix` | SSH server configuration |
| `modules/server/cloudflare.nix` | Cloudflared tunnel + DDNS updater |
| `modules/server/docker-networks.nix` | Docker daemon + network definitions |
| `modules/server/wireguard.nix` | WireGuard VPN server |
| `modules/server/syncthing.nix` | Syncthing file sync (server side) |
| `modules/server/traefik.nix` | Traefik reverse proxy |
| `modules/users/server/server.nix` | Server user account |

### Services overview

- **WireGuard** — VPN gateway for all machines in the network
- **Syncthing** — file synchronisation hub; clients (laptop, desktop) sync to this node
- **Traefik** — reverse proxy routing traffic to Docker containers
- **Cloudflare DDNS** — keeps the DNS record updated with the current public IP
- **Docker** — container runtime with predefined internal networks

## File structure (server-relevant)

```
hosts/server/
├── configuration.nix          # Host entrypoint — imports all modules
└── hardware-configuration.nix # Auto-generated hardware config

modules/server/
├── apps.nix                   # CLI packages
├── cloudflare.nix             # Cloudflared + dyndns
├── docker-networks.nix        # Docker daemon + networks
├── ssh.nix                    # SSH server settings
├── syncthing.nix              # Syncthing (server role)
├── traefik.nix                # Traefik reverse proxy
└── wireguard.nix              # WireGuard server

modules/users/server/
└── server.nix                 # Server user definition
```

## Useful commands

```bash
# Apply config
sudo nixos-rebuild switch --flake .#server

# WireGuard
systemctl status wireguard-wg0.service
sudo wg show

# Cloudflare DDNS
systemctl status cloudflare-dyndns.service

# Docker
docker ps
docker network ls

# Syncthing dashboard
http://localhost:8384
```

## Secrets

| Secret | Path |
|---|---|
| WireGuard private key | `/var/wireguard/` |
| SSH host keys | `/etc/ssh/` |
