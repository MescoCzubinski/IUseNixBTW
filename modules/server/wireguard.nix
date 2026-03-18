{ config, pkgs, ... }:

{
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking.nat = {
    enable = true;
    externalInterface = "enp1s0f0";
    internalInterfaces = [ "wg0" ];
  };

  networking.firewall.trustedInterfaces = [ "wg0" ];
  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.1/24" ];
    listenPort = 51820;
    mtu = 1380;
    privateKeyFile = "/var/lib/wireguard/privatekey";

    peers = [
      {
        publicKey = "hmEmY4RPiWP7Kxh3sbbtwF1P62AAcI9YB2A3upSM2mg="; # myLaptop
        allowedIPs = [ "10.0.0.2/32" ];
      }
      {
        publicKey = "kFT+XItD52EPR+ympcOk1GthXIHqgyl1hXQOQB/CO3Q="; # myDesktop
        allowedIPs = [ "10.0.0.3/32" ];
      }
      {
        publicKey = "G5zMbEwhkxeWaCXPZVS0DwY3J2szzw40jPCNoxa5ogA="; # myPhone
        allowedIPs = [ "10.0.0.4/32" ];
      }
    ];
  };
}
