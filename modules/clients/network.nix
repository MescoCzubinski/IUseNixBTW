{ private, ... }:

{
  networking.extraHosts = ''
    ${private.serverVpnIp} syncthing.${private.domain}
    ${private.serverVpnIp} beszel.${private.domain}
    ${private.serverVpnIp} argocd.${private.domain}
    ${private.serverVpnIp} convert.${private.domain}
    ${private.serverVpnIp} stirling.${private.domain}
  '';
}
