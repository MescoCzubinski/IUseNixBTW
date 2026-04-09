{ pkgs, ... }: 

{
  virtualisation.docker.enable = true;

  systemd.services.docker-networks = {
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      check_net() { ${pkgs.docker}/bin/docker network inspect "$1" >/dev/null 2>&1; }
      check_net "external" || ${pkgs.docker}/bin/docker network create external
      check_net "internal" || ${pkgs.docker}/bin/docker network create internal
    '';
  };
}