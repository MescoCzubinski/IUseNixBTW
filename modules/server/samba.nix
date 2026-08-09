{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.cifs-utils pkgs.samba ];
  fileSystems."/home/mieszko/Shared" = {
    device = "//10.0.0.1/Shared";
    fsType = "cifs";

    options = [
      "credentials=/etc/samba/secrets"
      "uid=1000"
      "gid=100"
      "vers=3.0"
      "port=30445"
    ];
  };
}
