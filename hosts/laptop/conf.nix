{ config, pkgs, ... }:

{
  networking.hostName = "laptop";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # code editors
    code-cursor
    vscode

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
    spotify

    # utilities
    onlyoffice-desktopeditors
	  brave

    # terminal
    kitty

    # desktop environment
    waybar # task bar
    wlogout # logout screen
    superfile # file manager
    hypridle # power management
    hyprpaper # wallpaper manager
    hyprlock # screen locker
    rofi # application launcher
    mako # notification daemon
    brightnessctl # screen brightness
    cliphist # clipboard manager

    # screenshots
    grim
    slurp
    wl-clipboard

    neofetch # fancy terminal info

    networkmanagerapplet # network manager
    blueman # bluetooth manager
    bibata-cursors # cursor theme
  ];

  system.stateVersion = "25.11";
}
