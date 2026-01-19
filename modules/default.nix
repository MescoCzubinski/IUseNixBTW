{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "exfat" ];

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };
  nix.settings.auto-optimise-store = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.upower.enable = true;

  console.keyMap = "pl2";
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  services.udisks2.enable = true;
  security.polkit.enable = true;
  security.pam.services.hyprlock = {};

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;
  services.tlp.enable = true;
  users.users.mieszko = {
    isNormalUser = true;
    description = "mieszko";
    extraGroups = [ "networkmanager" "wheel" "video"];
  };

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

  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
        General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # main
    hypridle # power management
    hyprpaper # wallpaper manager
    hyprlock # screen locker
    waybar # task bar

    rofi # application launcher
    kitty # terminal
    yazi # file manager

    zip # zip command
    unzip # unzip command

    # management
    bluetui # bluetooth tui manager
    impala # network tui manager
    brightnessctl # screen brightness controller
    playerctl # media controller
    swaynotificationcenter # notification center

    # file system
    exfatprogs # exfat filesystem support
    udiskie # automounting drives

    # screenshots
    cliphist # clipboard manager
    grim # screenshot tool
    slurp # area selection tool
    wl-clipboard # clipboard utilities

    # theme & style
    neofetch # fancy terminal info
    bibata-cursors # cursor theme
  ];

  programs.hyprland.enable = true;
}
