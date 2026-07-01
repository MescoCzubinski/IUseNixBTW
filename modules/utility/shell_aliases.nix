{ config, pkgs, ... }:

{
  environment.shellAliases = {
    "sl" = "ls";
    "la" = "ls -a";
    "dc" = "cd";
    "c" = "cd";
    "cd.." = "cd ..";
    "cl" = "clear";
    "op" = "brave";
    "code" = "codium";

    "neofetch" = "fastfetch";

    "git-commit" = "git add . && git commit -m";
    "git-main" = "git fetch origin main && git merge origin/main";
    "git-count" = "git ls-files | grep -vE \"\\.(png|jpg|jpeg|gif|pdf|md)$\" | xargs wc -l";

    "wg-status" = "sudo wg show && systemctl status wireguard-wg0.service && ping 10.0.0.1";

    "nix-use" = "export NIXPKGS_ALLOW_UNFREE=1 && nix-shell -p";
    "nix-clean" = "sudo nix-collect-garbage -d";
    "nix-update" = "cd ~/.nixos && sudo nix flake update";

    "nix-laptop" = "(cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#laptop)";
    "nix-desktop" = "(cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#desktop)";

    "backup-mount" = "sudo cryptsetup luksOpen /dev/sda1 backup && sudo mkdir -p /mnt/backup && sudo mount /dev/mapper/backup /mnt/backup";
    "backup-umount" = "sudo umount /mnt/backup && sudo cryptsetup luksClose backup";
    "backup-sync" = "rsync -avh --delete ~/Pictures/ /mnt/backup/Auto/Pictures/ && rsync -avh --delete ~/Projects/ /mnt/backup/Auto/Projects/ && rsync -avh --delete ~/Saved/ /mnt/backup/Auto/Saved/ && rsync -avh --delete ~/SecondBrain/ /mnt/backup/Auto/Notes/ && rsync -avh --delete ~/.nixos/ /mnt/backup/Auto/NixOS/";
  };
}
