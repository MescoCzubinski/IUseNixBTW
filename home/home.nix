{ pkgs, ... }:

{
  imports = [
    ./fish.nix # fish shell + prompt
    ./atuin.nix # shell history
    ./folders.nix # home folders
    ./vscode.nix # vscodium
  ];

  home.username = "mieszko";
  home.homeDirectory = "/home/mieszko";
  home.stateVersion = "26.05";

  home.file = {
    ".config/hypr".source = ./dotfiles/hypr;
    ".config/kitty".source = ./dotfiles/kitty;
    ".config/fastfetch".source = ./dotfiles/fastfetch;
    ".config/vicinae/settings.json".source = ./dotfiles/vicinae/settings.json;
    ".config/mako".source = ./dotfiles/mako;
    ".config/waybar".source = ./dotfiles/waybar;
    ".config/yazi".source = ./dotfiles/yazi;
    ".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice";

    "Notes/.obsidian/app.json".source = ./dotfiles/obsidian/app.json;
    "Notes/.obsidian/appearance.json".source = ./dotfiles/obsidian/appearance.json;
    "Notes/.obsidian/backlink.json".source = ./dotfiles/obsidian/backlink.json;
    "Notes/.obsidian/core-plugins.json".source = ./dotfiles/obsidian/core-plugins.json;
    "Notes/.obsidian/daily-notes.json".source = ./dotfiles/obsidian/daily-notes.json;
    "Notes/.obsidian/switcher.json".source = ./dotfiles/obsidian/switcher.json;
  };

  programs.home-manager.enable = true;
}
