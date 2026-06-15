{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
  };
  programs.virt-manager.enable = true;
  users.users.mieszko.extraGroups = ["libvirtd"];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    swtpm
  ];
}
