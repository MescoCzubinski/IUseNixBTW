# NixOS Configuration & Dotfiles

This repository contains my system-wide NixOS configuration and my user-specific dotfiles.

### Rebuild

```bash
sudo nixos-rebuild switch --flake .#{HOST_NAME}
```

Replace `{HOST_NAME}` with your actual host name

### Update

```bash
sudo nix flake update
```

### WireGuard Configuration

```bash
*VPN status*
systemctl status wireguard-wg0.service

*state of connection*
sudo wg show
```

### Cloudflare dyndns (on server)

```bash
*Status*
systemctl status cloudflare-dyndns.service
```

### Pendrive dir

```bash
cd /run/media/mieszko
```

### Syncthing dashboard

[[http://localhost:8384](http://localhost:8384)]

### Secrets localization

- GitHub ssh keys are in `/.ssh/`,
- wireguard VPN keys are in `/var/wireguard/`,
