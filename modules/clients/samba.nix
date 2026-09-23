{ pkgs, private, ... }:

{
  environment.systemPackages = [ pkgs.cifs-utils pkgs.samba ];
  fileSystems."/home/mieszko/Shared" = {
    device = "//${private.serverVpnIp}/Shared";
    fsType = "cifs";

    options = [
      "credentials=/etc/samba/secrets"
      "uid=1000"
      "gid=100"
      "vers=3.1.1"
      "port=445"
      "_netdev"
      "soft"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=10s"
    ];
  };
}
