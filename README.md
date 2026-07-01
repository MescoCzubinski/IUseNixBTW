# NixOS Configuration

Personal NixOS configuration managed as a flake, covering three machines: **laptop**, **desktop**.

## What is it

A single repository that declaratively defines the full system state for all machines — packages, services, networking, dotfiles, and user environments. Changes are version-controlled and reproducible.

## Rules / conventions

- **One module, one concern** — each `.nix` file configures a single feature or service.
- **`common.nix` is imported by all hosts** — system-wide settings (locale, boot, nix GC) live there.
- **Host configs are thin** — `hosts/*/configuration.nix` only imports modules; logic lives in modules.
- **Home-manager runs inside NixOS** — used on laptop and desktop.
- **Secrets are not in this repo** — SSH keys live in `~/.ssh/`, WireGuard keys in `/var/wireguard/`.
- **`nixos-unstable` channel** — all machines track unstable for latest packages.
- **`allowUnfree = true`** — required for nvidia drivers, cursor, discord, steam, etc.

## Common commands

```bash
# Apply configuration
sudo nixos-rebuild switch --flake .#laptop    # or desktop

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

# latex generation:
pdflatex file.tex
```

## Secrets locations

| Secret             | Path              |
| ------------------ | ----------------- |
| GitHub SSH keys    | `~/.ssh/`         |
| WireGuard VPN keys | `/var/wireguard/` |

## Useful links

- [NixOS package search](https://search.nixos.org/packages?channel=unstable)
- [Home Manager options](https://nix-community.github.io/home-manager/options.xhtml)
- [NixOS options search](https://search.nixos.org/options)
