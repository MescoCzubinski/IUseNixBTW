{ config, pkgs, ... }:

{
  services.tlp.enable = true; # battery
  services.thermald.enable = true; # Intel thermal management
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ]; # hardware video decoding

  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "nosleep" (builtins.readFile ../../scripts/nosleep.sh))
  ];

  # signal when low battery
  home-manager.users.mieszko.services.batsignal = {
    enable = true;
    extraArgs = [
      "-w" "15" "-c" "10" "-d" "5"
      "-W" "Battery low"
      "-C" "Battery critical!"
      "-D" "${pkgs.libnotify}/bin/notify-send -u critical 'Battery very low!'"
    ];
  };

  # idle: screen off after 10 min, suspend after 15 min on battery
  home-manager.users.mieszko.services.hypridle.settings = {
    general.after_sleep_cmd = "hyprctl dispatch dpms on";
    listener = [
      {
        timeout = 600;
        "on-timeout" = "hyprctl dispatch dpms off";
        "on-resume" = "hyprctl dispatch dpms on";
      }
      {
        timeout = 900;
        "on-timeout" = "[ \"$(cat /sys/class/power_supply/AC/online)\" = 0 ] && ! systemctl --user is-active -q nosleep && systemctl suspend";
      }
    ];
  };

  # touchpad keeps acceleration
  home-manager.users.mieszko.wayland.windowManager.hyprland.settings.device = [
    {
      name = "dell0a37:00-06cb:ce65-touchpad";
      accel_profile = "adaptive";
    }
  ];

  # turned on/off by `nosleep`
  systemd.user.services.nosleep = {
    description = "Keep the laptop awake with the lid closed";
    serviceConfig.ExecStart = "${pkgs.systemd}/bin/systemd-inhibit --what=sleep:handle-lid-switch --who=nosleep --why=nosleep ${pkgs.coreutils}/bin/sleep infinity";
  };

  # fingerprint reader
  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-broadcom;
  };
  systemd.services.fprintd.serviceConfig.TimeoutStopSec = "10s";
  security.pam.services.login.fprintAuth = false;
  security.pam.services.hyprlock.fprintAuth = false;
  security.pam.services.sudo.rules.auth.fprintd.order = config.security.pam.services.sudo.rules.auth.unix.order + 10;
  security.pam.services.polkit-1.rules.auth.fprintd.order = config.security.pam.services.polkit-1.rules.auth.unix.order + 10;
  home-manager.users.mieszko.programs.hyprlock.settings.auth."fingerprint:enabled" = true;

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
