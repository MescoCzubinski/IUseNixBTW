{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
    stdenv.cc.cc
    xorg.libX11
  ];

  services.xserver.displayManager.setupCommands = '' ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output HDMI-A-1 --mode 3840x2160 --pos 3840x0 --rotate normal '';
}
