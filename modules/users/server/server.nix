{ config, pkgs, ... }:

{
  users.users.server = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICyng5wIxyEngVsjyM/uppy9XCx/vq/ScaywINFGR7cP mieszkoczubinski@gmail.com>" # myDesktop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMFY5L+PvllH8W0QskGoxmDaolWcji+XO4LkFapwVHSB mieszkoczubinski@gmail>" # myLaptop
    ];
  };
}
