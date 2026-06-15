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

    "nix-server" = "tmux new-session -d 'cd ~/.nixos && git pull && sudo nixos-rebuild boot --flake .#server && sudo reboot' && tmux attach";
  };
}
