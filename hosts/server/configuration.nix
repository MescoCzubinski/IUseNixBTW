{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  networking.hostName = "myServer";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  users.users.server = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7id0hlQ9TJgBW0fZQUvsk52hfuYXMqOKOZTp714XZi mieszkoczubinsk>" # myDesktop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrYQqZva0AiBV/JH/eB3J4ddNu9BybzmaQwOWe8DMdo mieskzocubinski>" # myLaptop
    ];
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "ebf2e2d0-910a-435c-b687-a8c1feadda2f" = {
        credentialsFile = "/var/lib/cloudflare/tunnel-key.json";
        default = "http_status:404";
        ingress = {
          "ssh.czubinski.dev" = "ssh://127.0.0.1:22";
          "www.czubinski.dev" = "http://172.19.0.100:80";
          "czubinski.dev" = "http://172.19.0.100:80";
        };
      };
    };
  };

  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = "/var/lib/cloudflare-dyndns/token";
    domains = [ "vpn.czubinski.dev" ];
  };

  networking.nat = {
    enable = true;
    externalInterface = "enp1s0f0";
    internalInterfaces = [ "wg0" ];
  };

  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [ 51820 21027 ];

  networking.firewall.trustedInterfaces = [ "wg0" ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.1/24" ];
    listenPort = 51820;
    mtu = 1380;
    privateKeyFile = "/var/lib/wireguard/privatekey";

    peers = [
      {
        publicKey = "XFDjYK4aur6lP5jdhZ7jbjh3K8TFRAMzrZ/VuHKQS0g="; # myDesktop
        allowedIPs = [ "10.0.0.3/32" "10.0.0.0/24" ];
      }
      {
        publicKey = "krLtF9fME9f6zC8oziKcnFEZy9fOyQet61mwqRkpgGY="; # myLaptop
        allowedIPs = [ "10.0.0.2/32" "10.0.0.0/24" ];
      }
    ];
  };

  environment.systemPackages = with pkgs; [ wget cloudflared git kitty ];

  virtualisation.docker.enable = true;

  systemd.services.docker-networks = {
    description = "create Docker bridge networks";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      check_net() { ${pkgs.docker}/bin/docker network inspect "$1" >/dev/null 2>&1; }
      check_net "internal" || ${pkgs.docker}/bin/docker network create internal
      check_net "external" || ${pkgs.docker}/bin/docker network create external
    '';
  };

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
      options = {
        globalAnnounceEnabled = false;
        relaysEnabled = false;
      };
      devices = {
        "myDesktop" = {
          id = "ER6WOU5-JJ237EM-7UXU73P-5EJ3WVF-UBVS6IV-474HVTX-SCNNY3P-YOWU3Q6"; # myDesktop
          addresses = [ "tcp://10.0.0.3:22000" ];
        };
        "myLaptop" = {
          id = "QLMUBML-NJUEYE4-GTHVI56-QTQQXKC-GDXLJ64-X2JFNR2-KU6O6CA-TVCJSAD"; # myLaptop
          addresses = [ "tcp://10.0.0.2:22000" ];
        };
      };
      folders = {
        "SecondBrain" = {
          path = "/mnt/nas/SecondBrain";
          devices = [ "myDesktop" "myLaptop" ];
        };
        "Pictures" = {
          path = "/mnt/nas/Pictures";
          devices = [ "myDesktop" "myLaptop" ];
        };
      };
    };
  };

  system.stateVersion = "24.11";
 }
