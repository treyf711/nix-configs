{ config, pkg, libs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
