{ config, private, ... }:

let
  host = {
    myDesktop = { ip = "192.168.0.3/24"; endpoint = "192.168.1.100:51820"; };
    myLaptop  = { ip = "192.168.0.2/24"; endpoint = "vpn.czubinski.dev:51820"; };
  }.${config.networking.hostName};
in
{
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.rp_filter" = 0;
    "net.ipv4.conf.wg0.rp_filter" = 0;
  };

  networking.networkmanager.unmanaged = [ "wg0" ];
  networking.firewall.trustedInterfaces = [ "wg0" ];
  networking.firewall.checkReversePath = false;

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ host.ip ];
      mtu = 1380;
      privateKeyFile = "/etc/wireguard/private.key";

      peers = [
        {
          publicKey = private.wgPeerKey;
          allowedIPs = [ "192.168.0.0/24" ];
          endpoint = host.endpoint;
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
