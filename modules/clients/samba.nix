{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.cifs-utils pkgs.samba ];
  fileSystems."/home/mieszko/Shared" = {
    device = "//192.168.0.1/Shared";
    fsType = "cifs";

    options = [
      "credentials=/etc/samba/secrets"
      "uid=1000"
      "gid=100"
      "file_mode=0644"
      "dir_mode=0755"
      "vers=3.1.1"
      "port=445"
      "_netdev"
      "soft"
      "echo_interval=1"
      "actimeo=30"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=5s"
    ];
  };
}
