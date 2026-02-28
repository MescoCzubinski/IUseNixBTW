{ pkgs, ... }:

{
  programs.hyprland.enable = true;

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
  ];
}
