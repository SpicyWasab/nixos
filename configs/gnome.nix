# Everything gnome-specific
{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    libfprint
  ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.desktopManager.gnome.sessionPath = [ pkgs.gdm ];
  services.flatpak.enable = true;
  services.fwupd.enable = true; # trying to get GNOME security tab to work

  # to allow packet / quickshare and GSConnect (probably)
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } { from = 9300 ; to = 9300; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  # for KDE gsconnect to work
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  services.fprintd.enable = true; 
  # security.pam.services.login.fprintAuth = lib.mkForce true;
  # security.pam.services.gdm-fingerprint.fprintAuth = lib.mkForce true;
  # If simply enabling fprintd is not enough, try enabling fprintd.tod...
  # services.fprintd.tod.enable = true;
  # ...and use one of the next four drivers
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-elan;
}
