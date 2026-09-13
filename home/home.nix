{ pkgs, ... }:

{
  imports = [
    ./terminal/fish.nix # fish shell + prompt
    ./terminal/atuin.nix # shell history
    ./terminal/kitty.nix # kitty terminal
    ./terminal/yazi.nix # yazi file manager + file picker
    ./hyprland/hyprland.nix # hyprland compositor
    ./hyprland/hypridle.nix # idle daemon
    ./hyprland/hyprlock.nix # lock screen
    ./hyprland/hyprpaper.nix # wallpaper daemon
    ./folders.nix # home folders
    ./vscode.nix # vscodium
  ];

  home.username = "mieszko";
  home.homeDirectory = "/home/mieszko";
  home.stateVersion = "26.05";
  home.file = {
    ".config/fastfetch".source = ./dotfiles/fastfetch;
    ".config/vicinae/settings.json".source = ./dotfiles/vicinae/settings.json;
    ".config/mako".source = ./dotfiles/mako;
    ".config/waybar".source = ./dotfiles/waybar;
    ".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice";
  };

  programs.home-manager.enable = true;
}
