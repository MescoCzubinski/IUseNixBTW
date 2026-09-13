{ config, pkgs, ... }:

{
  environment.shellAliases = {
    "ls" = "eza --grid --icons --hyperlink --color --group-directories-first --no-symlinks";
    "sl" = "eza --grid --icons --hyperlink --color --group-directories-first --no-symlinks";
    "la" = "eza --grid --icons --hyperlink --color --group-directories-first --no-symlinks --all";
    "al" = "eza --grid --icons --hyperlink --color --group-directories-first --no-symlinks --all";
    "ll" = "eza --oneline --icons --hyperlink --color --group-directories-first --no-symlinks --all --long";

    "rename" = "batch-rename";

    "dc" = "cd";
    "c" = "cd";
    "cd.." = "cd ..";

    "findd" = "find . -type d -name";
    "findf" = "find . -type f -name";

    "grep" = "grep --color=auto";
    "egrep" = "egrep --color=auto";
    "fgrep" = "fgrep --color=auto";

    "img" = "chafa";
    "open" = "zen-beta";
    "neofetch" = "fastfetch";
    "myip" = "curl ifconfig.me";

    "codium" = "codium 2>/dev/null";
    "code" = "codium 2>/dev/null";
    "cdoe" = "codium 2>/dev/null";

    "git-count" = "git ls-files | grep -vE '\\.(png|jpg|jpeg|gif|pdf|md|json|csv|txt|lock)$' | xargs wc -l";

    "nix-use" = "export NIXPKGS_ALLOW_UNFREE=1 && nix-shell -p";
    "nix-clean" = "sudo nix-collect-garbage -d";
    "nix-update" = "cd ~/.nixos && sudo nix flake update";

    "nix-laptop" = "cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#laptop";
    "nix-laptop-boot" = "cd ~/.nixos && git add . && sudo nixos-rebuild boot --flake .#laptop";
    "nix-desktop" = "cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#desktop";
    "nix-desktop-boot" = "cd ~/.nixos && git add . && sudo nixos-rebuild boot --flake .#desktop";

    "backup-sync" = "rsync -avh --delete ~/Notes/ /run/media/mieszko/Backup/Auto/Notes/ && rsync -avh --delete --exclude='.venv' --exclude='node_modules' ~/Projects/ /run/media/mieszko/Backup/Auto/Projects/ && rsync -avh --delete ~/Pictures/ /run/media/mieszko/Backup/Auto/Pictures/ && rsync -avh --delete ~/Saved/ /run/media/mieszko/Backup/Auto/Saved/ && rsync -avh --delete ~/.nixos/ /run/media/mieszko/Backup/Auto/NixOS/";
  };
}
