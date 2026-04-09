{ pkgs, ... }:

{
  systemd.services.traefik = {
    after = [ "docker.service" "docker-networks.service" "network-online.target" ];
    wants = [ "docker.service" "docker-networks.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "/opt/infra";
      ExecStart = "${pkgs.docker}/bin/docker compose up -d";
      ExecStop  = "${pkgs.docker}/bin/docker compose down";
    };
  };
}