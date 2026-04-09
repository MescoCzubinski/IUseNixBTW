{ pkgs, lib, ... }:

let
  yaziPicker = pkgs.writeShellScript "yazi-picker" ''
    kitty -e yazi --chooser-file="$1"
  '';
in

{
  # hyprland
  programs.hyprland.enable = true;
  security.pam.services.hyprlock = {};

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-termfilechooser
    ];
    config.hyprland = {
      default = [ "hyprland" "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
    };
  };

  environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${yaziPicker}
  '';

  # fonts
  fonts.packages = with pkgs; [
    fira-code
    inter
    nerd-fonts.fira-code
  ];
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "FiraCode Nerd Font" ];
      sansSerif = [ "Inter" ];
      serif     = [ "Inter" ];
    };
  };

  environment.systemPackages = with pkgs; [
    # main
    hypridle # power management
    hyprpaper # wallpaper manager
    hyprlock # screen locker
    waybar # task bar

    vicinae # application launcher
    kitty # terminal (tui fallback)
    yazi # file manager

    # management
    bluetui # bluetooth tui manager
    impala # network tui manager
    brightnessctl # screen brightness controller
    playerctl # media controller (SUPER + space = pause/play)
    swaynotificationcenter # notification center

    # screenshots
    hyprshot # screenshots
    wl-clipboard # clipboard utilities

    # theme & style
    fastfetch # fancy terminal info
    cmatrix # matrix effect
    bibata-cursors # cursor theme
  ];
}
