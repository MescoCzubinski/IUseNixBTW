{ pkgs, ... }:

{
  networking.extraHosts = ''
    127.0.0.1 syncthing.czubinski.dev
    127.0.0.1 beszel.czubinski.dev
  '';

  systemd.services.forward-web = {
    description = "Forward local 80 to cluster web NodePort";
    after = [ "wireguard-wg0.service" ];
    wants = [ "wireguard-wg0.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat TCP4-LISTEN:80,bind=127.0.0.1,fork,reuseaddr TCP4:10.0.0.1:30001";
      Restart = "always";
      RestartSec = 2;
    };
  };

  systemd.services.forward-websecure = {
    description = "Forward local 443 to cluster websecure NodePort";
    after = [ "wireguard-wg0.service" ];
    wants = [ "wireguard-wg0.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat TCP4-LISTEN:443,bind=127.0.0.1,fork,reuseaddr TCP4:10.0.0.1:30002";
      Restart = "always";
      RestartSec = 2;
    };
  };
}
