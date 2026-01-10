# Everything gnome-specific
{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [

  ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.flatpak.enable = true;
}
