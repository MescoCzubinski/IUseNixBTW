{ config, pkgs, ... }:

{
  environment.shellAliases = {
    "ls" = "eza --grid --icons --hyperlink --color --group-directories-first --no-symlinks";
    "sl" = "eza --grid --icons --hyperlink --color --group-directories-first --no-symlinks";
    "la" = "eza --grid --icons --hyperlink --color --group-directories-first --no-symlinks --all";
    "al" = "eza --grid --icons --hyperlink --color --group-directories-first --no-symlinks --all";
    "ll" = "eza --oneline --icons --hyperlink --color --group-directories-first --no-symlinks --all --long";

    "dc" = "cd";
    "c" = "cd";
    "cd." = "cd ..";
    "cd.." = "cd ..";

    "findd" = "find . -type d -name";
    "findf" = "find . -type f -name";

    "img" = "chafa";
    "open" = "zen-beta";
    "neofetch" = "fastfetch";
    "myip" = "curl ifconfig.me";

    "codium" = "codium 2>/dev/null";
    "code" = "codium 2>/dev/null";
    "coed" = "codium 2>/dev/null";
    "cdoe" = "codium 2>/dev/null";
    "ocde" = "codium 2>/dev/null";

    "git-count" = "git ls-files | grep -vE '\\.(png|jpg|jpeg|gif|pdf|md|json|csv|txt|lock)$' | xargs wc -l";
    "git-count-docs" = "git ls-files | grep -vE '\\.(png|jpg|jpeg|gif|pdf|json|csv|txt|lock)$' | xargs wc -l";

    "nix-edit" = "code ~/.nixos/ && exit";
    "nix-use" = "export NIXPKGS_ALLOW_UNFREE=1 && nix-shell -p";
    "nix-clean" = "sudo nix-collect-garbage -d";
    "nix-update" = "cd ~/.nixos && sudo nix flake update";

    "nix-laptop" = "cd ~/.nixos && git add . && sudo nixos-rebuild switch --impure --flake .#laptop";
    "nix-laptop-boot" = "cd ~/.nixos && git add . && sudo nixos-rebuild boot --impure --flake .#laptop";
    "nix-desktop" = "cd ~/.nixos && git add . && sudo nixos-rebuild switch --impure --flake .#desktop";
    "nix-desktop-boot" = "cd ~/.nixos && git add . && sudo nixos-rebuild boot --impure --flake .#desktop";

    "wg-start" = "sudo systemctl start wireguard-wg0.service";
    "wg-stop" = "sudo systemctl stop wireguard-wg0.service";
    "wg-status" = "sudo systemctl status wireguard-wg0.service";

    "backup-sync" = "rsync -avh --delete ~/Notes/ /run/media/mieszko/Backup/Auto/Notes/ && rsync -avh --delete --exclude='.venv' --exclude='node_modules' ~/Projects/ /run/media/mieszko/Backup/Auto/Projects/ && rsync -avh --delete ~/Pictures/ /run/media/mieszko/Backup/Auto/Pictures/ && rsync -avh --delete ~/Saved/ /run/media/mieszko/Backup/Auto/Saved/ && rsync -avh --delete ~/.nixos/ /run/media/mieszko/Backup/Auto/NixOS/";
    "rename" = "batch-rename";
  };
}
