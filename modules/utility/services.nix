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
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

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
  systemd.user.services.mpris-proxy = {
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  # auto-mount
  services.udisks2.enable = true;

  # zipping
  environment.systemPackages = with pkgs; [
    zip # z ip command
    unzip # unzip command
  ];
}
