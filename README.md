# NixOS Configuration & Dotfiles

This repository contains my system-wide NixOS configuration and my user-specific dotfiles.

## 🛠️ Post-Reinstall Recovery

After a fresh system reinstall, follow these steps to restore the environment:

### 1. Restore the Repository

Clone or copy this repository into the standard NixOS directory:

```bash
sudo git clone https://github.com/MescoCzubinski/nixos /etc/nixos
```

### 2. Rebuild

```bash
sudo nixos-rebuild switch --flake .#{HOST_NAME}
```

Replace `#{HOST_NAME}` with your actual host name

### 3. Update

```bash
sudo nix flake update
```

### WireGuard Configuration

```bash
sudo systemctl start wireguard-wg0.service

sudo systemctl stop wireguard-wg0.service
```

### Pendrive dir

```bash
cd /run/media/mieszko
```
