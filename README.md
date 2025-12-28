# NixOS Configuration & Dotfiles

This repository contains my system-wide NixOS configuration and my user-specific dotfiles.

## 🛠️ Post-Reinstall Recovery

After a fresh system reinstall, follow these steps to restore the environment:

### 1. Restore the Repository
Clone or copy this repository into the standard NixOS directory:

```bash
git clone https://github.com/MescoCzubinski/nixos
```

### 2. Restore the Repository
Link all packages to .config file (symoblic links)
```bash
ln -s /etc/nixos/dotfiles/{name} ~/.config/{name}
```
