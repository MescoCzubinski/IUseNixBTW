{ pkgs, ... }:

{
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
      ips = [ "10.0.0.2/24" ];
      mtu = 1380;
      privateKeyFile = "/etc/wireguard/private.key";

      peers = [
        {
          publicKey = "4G7+p+7ntdJ97Cc09AOK0XPfZTndx18b89X6EKNIKzY=";
          allowedIPs = [ "10.0.0.0/24" ];
          endpoint = "vpn.czubinski.dev:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
