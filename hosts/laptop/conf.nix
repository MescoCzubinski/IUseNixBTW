{ config, pkgs, ... }:

{
  networking.hostName = "laptop";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # code editors
    vscode
    code-cursor

    # antigravity
    google-antigravity
    google-chrome

    # dev tools
    docker
    yaak

    # languages
    nodejs
    python3
    go

    # social
    discord
    signal-desktop

    # utilities
    onlyoffice-desktopeditors
	  brave
    spotify

    # terminal
    kitty

    # desktop environment
    waybar # task bar
    wlogout # logout screen
    hypridle # power management
    hyprpaper # wallpaper manager
    hyprlock # screen locker
    rofi # application launcher
    mako # notification daemon
    brightnessctl # screen brightness
    cliphist # clipboard manager
    playerctl # media controller
    networkmanagerapplet # network manager
    blueman # bluetooth manager

    # screenshots
    grim
    slurp
    wl-clipboard

    neofetch # fancy terminal info
    bibata-cursors # cursor theme
  ];

  system.stateVersion = "25.11";
}
