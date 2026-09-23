{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  nix.channel.enable = false;
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 8;
      consoleMode = "max";
    };
    timeout = 5;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;
  boot.supportedFilesystems = [ "exfat" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

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

  console.keyMap = "pl2";
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # permission management
  security.polkit.enable = true;

  services.dbus.implementation = "broker";
  services.upower.enable = true;

  # file system packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecurePredicate = pkg: pkgs.lib.hasPrefix "electron" (pkgs.lib.getName pkg);

  # machine-local values
  _module.args.private = import /etc/nixos/private.nix;

  # nixos-unstable
  _module.args.unstablePkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    parted # partition manager
    exfatprogs # exfat filesystem support
    udiskie # automounting drives
    cryptsetup # disk encription tool
    usbutils # USB utilites
  ];
}
