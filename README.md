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
```

### Cloudflare dyndns (on server)

```bash
*Status*
systemctl status cloudflare-dyndns.service

*state of connection*
sudo wg show
```

### Pendrive dir

```bash
cd /run/media/mieszko
```

### Syncthing dashboard

[click](http://localhost:8384)

### Secrets localization

- wireguard VPN keys are in `/var/wireguard/`,
