{ pkgs, ... }:

{
  security.sudo.extraRules = [{
    users = [ "mieszko" ];
    commands = [
      {
        command = "/run/current-system/sw/bin/systemctl start wireguard-wg0.service";
        options = [ "NOPASSWD" ];
      }
      {
        command = "/run/current-system/sw/bin/systemctl stop wireguard-wg0.service";
        options = [ "NOPASSWD" ];
      }
    ];
  }];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.rp_filter" = 0;
    "net.ipv4.conf.wg0.rp_filter" = 0;
  };

  networking.networkmanager.unmanaged = [ "wg0" ];
  networking.firewall.trustedInterfaces = [ "wg0" ];
  networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.firewall.checkReversePath = false;

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.0.0.3/24" ];
      mtu = 1380;
      privateKeyFile = "/var/wireguard/privatekey";

      peers = [
        {
          publicKey = "jJeab15xx4nWj+1b/mgs+WInhPJRKJbC/T73PBdBDU4=";
          allowedIPs = [ "10.0.0.1/32" "10.0.0.0/24" ];
          endpoint = "192.168.1.10051820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
