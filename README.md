# NixOS Configuration & Dotfiles

This repository contains my system-wide NixOS configuration and my user-specific dotfiles.

### Rebuild

```bash
sudo nixos-rebuild switch --flake .#{HOST_NAME}
```

Replace `#{HOST_NAME}` with your actual host name

### Update

```bash
sudo nix flake update
```

### WireGuard Configuration

```bash
*VPN start*
sudo systemctl start wireguard-wg0.service

*VPN stop*
sudo systemctl stop wireguard-wg0.service

*VPN is active*
systemctl is-active wireguard-wg0.service

*VPN status*
systemctl status wireguard-wg0.service
```

### Pendrive dir

```bash
cd /run/media/mieszko
```

### Secrets localization

- wireguard VPN keys are in `/var/wireguard/`,
- samba (NAS auto login) password file is in `/var/secret/smb-secrets`

  username=server
  password=
  domain=WORKGROUP
