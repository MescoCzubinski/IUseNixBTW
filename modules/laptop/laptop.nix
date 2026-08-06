{ pkgs, ... }:

{
  services.tlp.enable = true; # battery

  environment.systemPackages = with pkgs; [
    batsignal # signal when low battery
  ];

  # microfon led lamp
  services.udev.extraRules = ''
    SUBSYSTEM=="leds", KERNEL=="platform::micmute", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/leds/platform::micmute/brightness"
  '';
  systemd.services.micmute-led-perms = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/udevadm trigger --subsystem-match=leds";
    };
  };
}
