{ config, private, ... }:

let
  host = {
    myDesktop = { ip = "${private.desktopVpnIp}/24"; endpoint = "${private.serverIp}:51820"; };
    myLaptop  = { ip = "${private.laptopVpnIp}/24"; endpoint = "${private.vpnDomain}:51820"; };
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
