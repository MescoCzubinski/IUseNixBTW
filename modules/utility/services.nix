{ config, pkgs, ... }:

{
  # audio service
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # input devices service
  services.libinput.enable = true;

  # network service
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  # bluetooth service
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

  # mpris bluetooth demon
  systemd.user.services.mpris-proxy.wantedBy = [ "default.target" ];

  # auto-mount
  services.udisks2.enable = true;

  # secrets wallet
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    # secrets
    libsecret
    seahorse

    # zipping
    zip
    unzip
  ];

  security.pam.services.hyprlock.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
}
