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

    "nix-switch" = "cd ~/.nixos && git add . && nh os switch . -- --impure";
    "nix-boot" = "cd ~/.nixos && git add . && nh os boot . -- --impure";

    "wg-start" = "sudo systemctl start wireguard-wg0.service";
    "wg-stop" = "sudo systemctl stop wireguard-wg0.service";
    "wg-status" = "sudo systemctl status wireguard-wg0.service";
  };

  environment.systemPackages = [
    (pkgs.writeScriptBin "files-backup" (builtins.readFile ../../scripts/files-backup.sh))
    (pkgs.writeScriptBin "games-backup" (builtins.readFile ../../scripts/games-backup.sh))
    (pkgs.writeScriptBin "files-rename" (builtins.readFile ../../scripts/files-rename.sh))
  ];
}
