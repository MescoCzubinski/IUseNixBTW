{ pkgs, lib, ... }:

let
  yaziCd = pkgs.writeShellScriptBin "yazicd" ''
    tmp="$(mktemp -t yazi-cwd.XXXXXX)"
    ${pkgs.yazi}/bin/yazi "$@" --cwd-file="$tmp"
    cwd="$(cat -- "$tmp")"
    rm -f -- "$tmp"
    [ -n "$cwd" ] && cd -- "$cwd"
    exec ${pkgs.bashInteractive}/bin/bash -i
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

  # fonts
  fonts.packages = with pkgs; [
    fira-code
    inter
    nerd-fonts.fira-code
    font-awesome
  ];
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "FiraCode Nerd Font" ];
      sansSerif = [ "Inter" ];
      serif     = [ "Inter" ];
    };
  };

  # theme
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        cursor-theme = "Bibata-Modern-Ice";
        cursor-size = lib.gvariant.mkInt32 24;
        gtk-theme = "Adwaita-dark";
        color-scheme = "prefer-dark";
      };
    }
  ];

  environment.systemPackages = with pkgs; [
    # main
    hypridle # power management
    hyprpaper # wallpaper manager
    hyprlock # screen locker
    waybar # task bar

    vicinae # application launcher
    kitty # terminal
    eza # ls replacement
    chafa # terminal graphics
    yazi # file manager
    yaziCd
    btop # monitor of resources


    # management
    bluetui # bluetooth tui manager
    impala # network tui manager
    brightnessctl # screen brightness controller
    playerctl # media controller (SUPER + space = pause/play)
    mako # notification daemon (popups + do-not-disturb)
    pwvucontrol # microphone manager

    # screenshots
    hyprshot # screenshots
    wl-clipboard # clipboard utilities

    # theme & style
    fastfetch # fancy terminal info
    cmatrix # matrix effect
    bibata-cursors # cursor theme

    wtype # type characters into focused window
    jq # JSON processor (used by screen-rotation keybinds)
  ];
}
