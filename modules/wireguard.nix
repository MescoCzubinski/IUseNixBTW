{ config, pkgs, ... }:

{
  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.0.0.3/24" ];
      privateKeyFile = "/etc/wireguard/private.key";

      peers = [
        {
          publicKey = "1QoXfEjyK0+CjU/7EI4iqOLuZSAsUqaytm2Pgym0UkY=";
          allowedIPs = [ "10.0.0.0/24" ];
          endpoint = "80.49.56.236:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
