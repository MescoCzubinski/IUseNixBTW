{ config, pkgs, ... }:

{
  home.username = "mieszko";
  home.homeDirectory = "/home/mieszko";
  home.stateVersion = "25.11";

  home.file = {
    ".config/hypr/hypridle.conf".source = ./dotfiles/hypr/hypridle.conf;
    ".config/hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
    ".config/hypr/hyprlock.conf".source = ./dotfiles/hypr/hyprlock.conf;
    ".config/hypr/hyprpaper.conf".source = ./dotfiles/hypr/hyprpaper.conf;
    ".config/hypr/wallpaper.png".source = ./dotfiles/hypr/wallpaper.png;
    ".config/kitty".source = ./dotfiles/kitty;
    ".config/neofetch".source = ./dotfiles/neofetch;
    ".config/rofi".source = ./dotfiles/rofi;
    ".config/swaync".source = ./dotfiles/swaync;
    ".config/waybar".source = ./dotfiles/waybar;
    ".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice";
  };

  programs.home-manager.enable = true;
}
