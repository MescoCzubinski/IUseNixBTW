{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
      consoleMode = "max";
    };
    timeout = 5;
    efi.canTouchEfiVariables = true;
  };
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
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "syncthing" "users" ];
  };

  security.sudo.extraRules = [{
    users = [ "mieszko" ];
    commands = [
      {
        command = "/run/current-system/sw/bin/systemctl start wireguard-wg0.service";
        options = [ "NOPASSWD" ];
      }
      {
        command = "/run/current-system/sw/bin/systemctl stop wireguard-wg0.service";
        options = [ "NOPASSWD" ];
      }
    ];
  }];

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
  networking.networkmanager.unmanaged = [ "wg0" ];

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

  environment.shellAliases = {
    "sl" = "ls";
    "la" = "ls -a";
    "dc" = "cd";
    "c" = "cd";

    "nas" = "cd /home/mieszko/NAS && ls";
    "git-pull" = "git fetch && git pull";
    "nix-laptop" = "(cd ~/NixOS && git add . && sudo nixos-rebuild switch --flake .#laptop)";
    "nix-desktop" = "(cd ~/NixOS && git add . && sudo nixos-rebuild switch --flake .#desktop)";
    "nix-use" = "nix-shell -p";
    "nix-clean" = "sudo nix-collect-garbage -d";
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # zipping
    zip # zip command
    unzip # unzip command

    # file system
    parted # partition manager
    exfatprogs # exfat filesystem support
    udiskie # automounting drives
    usbutils # USB utils

    # theme & style
    neofetch # fancy terminal info
    bibata-cursors # cursor theme
  ];

  programs.hyprland.enable = true;
}
