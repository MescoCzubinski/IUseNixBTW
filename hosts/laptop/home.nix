{ config, pkgs, ... }:

{
  home.username = "mieszko";
  home.homeDirectory = "/home/mieszko";
  home.stateVersion = "25.11"; 

  home.file.".config/hypr".source = ../../dotfiles/hypr;
  home.file.".config/kitty".source = ../../dotfiles/kitty;
  home.file.".config/mako".source = ../../dotfiles/mako;
  home.file.".config/neofetch".source = ../../dotfiles/neofetch;
  home.file.".config/rofi".source = ../../dotfiles/rofi;
  home.file.".config/waybar".source = ../../dotfiles/waybar;

  programs.home-manager.enable = true;
}