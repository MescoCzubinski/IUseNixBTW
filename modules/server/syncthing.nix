{ config, pkgs, ... }:

{
  networking.firewall.interfaces."wg0".allowedTCPPorts = [ 22000 ];
  networking.firewall.interfaces."wg0".allowedUDPPorts = [ 21027 ];

  systemd.tmpfiles.rules = [
    "d /mnt 0755 root root -"
    "d /mnt/nas 0770 server users -"
    "d /var/lib/syncthing 0700 server users -"
  ];

  services.syncthing = {
    enable = true;
    user = "server";
    dataDir = "/mnt/nas";
    configDir = "/var/lib/syncthing";

    guiAddress = "10.0.0.1:8384";

    settings = {
      options.listenAddresses = [ "tcp://10.0.0.1:22000" ];

      options.globalAnnounceEnabled = false;
      options.relaysEnabled = false;

      devices = {
        "myLaptop" = {
          id = "LSMNEDP-BJVP5BQ-SL7J4EK-3H25RAG-LZWUTAN-QXDSZRP-MUPVK24-3BAWRAF"; # myLaptop
          addresses = [ "tcp://10.0.0.2:22000" ];
        };
        "myDesktop" = {
          id = "IFW3ZPK-FGBR63F-ZEKRKF3-EHZA2YU-65M2N2V-KXLSI5P-E4OHPNW-675ABAP"; # myDesktop
          addresses = [ "tcp://10.0.0.3:22000" ];
        };
        "myPhone" = {
          id = "J22COXJ-OIFALUG-ZQEJIHV-RALME62-QRPFDTW-GW35ZBK-W23T3L4-LUJSJAG"; # myPhone
          addresses = [ "tcp://10.0.0.4:22000" ];
        };
      };
      folders = {
        "SecondBrain" = {
          path = "/mnt/nas/SecondBrain";
          devices = [ "myDesktop" "myLaptop" "myPhone" ];
          type = "sendreceive";
        };
        "Pictures" = {
          path = "/mnt/nas/Pictures";
          devices = [ "myDesktop" "myLaptop" ];
          type = "sendreceive";
        };
        "Shared" = {
          path = "/mnt/nas/Shared";
          devices = [ "myDesktop" "myLaptop" "myPhone" ];
          type = "sendreceive";
        };
        "Memes" = {
          path = "/mnt/nas/Pictures/Memes";
          devices = [ "myPhone" ];
          type = "sendreceive";
        };
        "ReactionMemes" = {
          path = "/mnt/nas/Pictures/ReactionMemes";
          devices = [ "myPhone" ];
          type = "sendreceive";
        };
        "Phone" = {
          path = "/mnt/nas/Pictures/Phone";
          devices = [ "myPhone" ];
          type = "sendreceive";
        };
      };
    };
  };
}
