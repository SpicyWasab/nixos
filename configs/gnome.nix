# Everything gnome-specific
{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [

  ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.flatpak.enable = true;
  services.fwupd.enable = true; # trying to get GNOME security tab to work
}
