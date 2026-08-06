{ config, pkgs, ... }:

{
  environment.shellAliases = {
    "ls" = "ls --color=auto";
    "sl" = "ls --color=auto";
    "la" = "ls -a --color=auto";
    "ll" = "ls -alh --color=auto";

    "mv" = "mv -i";

    "dc" = "cd";
    "c" = "cd";
    "cd.." = "cd ..";

    "grep" = "grep --color=auto";
    "egrep" = "egrep --color=auto";
    "fgrep" = "fgrep --color=auto";

    "open" = "brave";
    "neofetch" = "fastfetch";

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

    "backup-mount" = "sudo cryptsetup luksOpen /dev/sda1 backup && sudo mkdir -p /mnt/backup && sudo mount /dev/mapper/backup /mnt/backup && sudo chown -R mieszko:users /mnt/backup";
    "backup-umount" = "sudo umount /mnt/backup && sudo cryptsetup luksClose backup";
    "backup-sync" = "rsync -avh --delete ~/Notes/ /mnt/backup/Auto/Notes/ && rsync -avh --delete --exclude='.venv' --exclude='node_modules' ~/Projects/ /mnt/backup/Auto/Projects/ && rsync -avh --delete ~/Pictures/ /mnt/backup/Auto/Pictures/ && rsync -avh --delete ~/Saved/ /mnt/backup/Auto/Saved/ && rsync -avh --delete ~/.nixos/ /mnt/backup/Auto/NixOS/";
  };
}
