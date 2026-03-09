{ pkgs, ... }:

{
  # display manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # hyperland
  programs.hyprland.enable =  true;
  security.pam.services.hyprlock = {};

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
  ];
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "FiraCode Nerd Font" ];
      sansSerif = [ "Fira Sans" ];
      serif     = [ "Fira Serif" ];
    };
  };

  environment.systemPackages = with pkgs; [
    # main
    hypridle # power management
    hyprpaper # wallpaper manager
    hyprlock # screen locker
    waybar # task bar

    rofi # application launcher
    kitty # terminal
    yazi # file manager

    # management
    bluetui # bluetooth tui manager
    impala # network tui manager
    brightnessctl # screen brightness controller
    playerctl # media controller (SUPER + space = pause/play)
    swaynotificationcenter # notification center

    # screenshots
    cliphist # clipboard manager
    hyprshot # screenshots
    wl-clipboard # clipboard utilities

    # theme & style
    fastfetch # fancy terminal info
    cmatrix # matrix effect
    bibata-cursors # cursor theme
  ];
}
