# NixOS Configuration

Personal NixOS configuration managed as a flake, covering three machines: **laptop**, **desktop**, and **server**.

## What is it

A single repository that declaratively defines the full system state for all machines — packages, services, networking, dotfiles, and user environments. Changes are version-controlled and reproducible.

## Structure

```
.nixos/
├── flake.nix                  # Entrypoint — defines all three hosts
├── flake.lock                 # Pinned dependency versions
├── hosts/
│   ├── laptop/                # Laptop-specific config + hardware
│   ├── desktop/               # Desktop-specific config + hardware
│   └── server/                # Server-specific config + hardware
├── modules/
│   ├── common.nix             # Shared base: boot, locale, nix settings
│   ├── client/                # Shared client modules (syncthing)
│   ├── desktop/               # Desktop-only modules (nvidia, logitech, wireguard)
│   ├── dev/                   # Development tools (editors, languages)
│   ├── games/                 # Gaming (Steam, Heroic/Epic)
│   ├── laptop/                # Laptop-only modules (battery, wireguard)
│   ├── server/                # Server modules (docker, traefik, cloudflare, ssh, syncthing, wireguard)
│   ├── users/
│   │   ├── mieszko/           # User account + home-manager modules
│   │   └── server/            # Server user account
│   └── utility/               # Common desktop utilities (apps, desktop env, services, aliases)
└── home/
    ├── home.nix               # Home-manager entrypoint (dotfiles, cursor, etc.)
    └── dotfiles/              # Raw config files managed by home-manager
```

## Rules / conventions

- **One module, one concern** — each `.nix` file configures a single feature or service.
- **`common.nix` is imported by all hosts** — system-wide settings (locale, boot, nix GC) live there.
- **Host configs are thin** — `hosts/*/configuration.nix` only imports modules; logic lives in modules.
- **Home-manager runs inside NixOS** — used on laptop and desktop; server has no home-manager.
- **Secrets are not in this repo** — SSH keys live in `~/.ssh/`, WireGuard keys in `/var/wireguard/`.
- **`nixos-unstable` channel** — all machines track unstable for latest packages.
- **`allowUnfree = true`** — required for nvidia drivers, cursor, discord, steam, etc.

## Common commands

```bash
# Apply configuration
sudo nixos-rebuild switch --flake .#laptop    # or desktop / server

# Update all flake inputs
sudo nix flake update

# Check WireGuard status
systemctl status wireguard-wg0.service
sudo wg show

# Check Cloudflare DDNS (server)
systemctl status cloudflare-dyndns.service

# Syncthing dashboard
http://localhost:8384

# USB / pendrive mount path
/run/media/mieszko
```

## Secrets locations

| Secret | Path |
|---|---|
| GitHub SSH keys | `~/.ssh/` |
| WireGuard VPN keys | `/var/wireguard/` |

## Useful links

- [NixOS package search](https://search.nixos.org/packages?channel=unstable)
- [Home Manager options](https://nix-community.github.io/home-manager/options.xhtml)
- [NixOS options search](https://search.nixos.org/options)
