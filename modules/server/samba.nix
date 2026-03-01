{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.cifs-utils ];

  fileSystems."/home/mieszko/NAS" = {
    device = "//10.0.0.1/NAS";
    fsType = "cifs";
    options = let
      mount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,uid=1000,gid=100";
    in [ "${mount_opts},credentials=/var/secret/smb-secrets" ];
  };
}
