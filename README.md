# I use NixOS BTW

My NixOS config for two machines, a **laptop** and a **desktop**. It's a single flake that sets up the whole system: packages, services, the Hyprland desktop, dotfiles and home-server clients.

## At a glance

| Area                | Choice                                              |
| ------------------- | --------------------------------------------------- |
| Compositor          | Hyprland (+ hypridle, hyprlock, hyprpaper)          |
| Login screen        | SDDM                                                |
| Bar / notifications | Waybar / Mako                                       |
| Launcher            | Vicinae                                             |
| Terminal / shell    | Kitty / Fish with Atuin history                     |
| File manager        | Yazi, which is also the system-wide GTK file picker |
| Editor              | VSCodium                                            |
| AI                  | Claude Code, Claude Desktop app                     |
| Browser             | Zen (from a flake input)                            |

## Layout

```

├── flake.nix              # inputs + one nixosConfiguration per host
├── hosts/
│   ├── laptop/            # configuration.nix + hardware-configuration.nix
│   └── desktop/
├── modules/               # NixOS (system-level) modules
│   ├── common.nix         # shared by every host: boot, nix settings, GC, locale
│   ├── utility/           # desktop, services, shell, apps, dev tools, login screen
│   ├── clients/           # home server clients: WireGuard, Samba, Syncthing, local DNS
│   ├── desktop/           # desktop-only: NVIDIA, Logitech
│   ├── laptop/            # laptop-only: TLP, battery alerts, mic-mute LED
│   ├── games/             # Steam (+ Proton-GE), Heroic
│   └── users/             # user account
└── home/                  # Home Manager (user-level) config
    ├── home.nix           # entry point, links raw dotfiles into ~/.config
    ├── hyprland/          # hyprland, hypridle, hyprlock, hyprpaper
    ├── terminal/          # fish, kitty, atuin, yazi
    ├── dotfiles/          # plain config files (waybar, mako, yazi, vicinae, fastfetch)
    └── wallpapers/
```

## Things worth a look

- **Stable with unstable picked per package.** [`modules/common.nix`](modules/common.nix) turns `nixpkgs-unstable` into a module argument called `unstablePkgs`. A module asks for `unstablePkgs` and uses it for a single package, like `unstablePkgs.claude-code` in [`dev.nix`](modules/utility/dev.nix).
- **Yazi as the file picker for every app.** [`desktop.nix`](modules/utility/desktop.nix) sends the portal's FileChooser to `xdg-desktop-portal-termfilechooser`. [`home/terminal/yazi.nix`](home/terminal/yazi.nix) then opens Yazi in Kitty whenever an app asks for a file or folder, which replaces the GTK dialog in browsers, Electron apps and others.
- **Focus-or-launch keybinds.** In [`hyprland.nix`](home/hyprland/hyprland.nix), `SUPER+D/N/S` switch to Discord, Obsidian or Spotify if one is already open, and launch it if not.
- **Fish tweaks.** In [`fish.nix`](home/terminal/fish.nix), Tab accepts the autosuggestion first and falls back to normal completion.
