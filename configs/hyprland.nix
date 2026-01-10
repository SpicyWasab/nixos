# Everything hyprland-specific
{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
     brightnessctl
     playerctl
     powertop
  ];

  programs.hyprland.enable = true;

  # programs.firefox.enable = true; # now using zen browser
  services.gvfs.enable = true; # required for nautilus
  services.gnome.glib-networking.enable = true;
  programs.dconf.enable = true; # trying really hard to make nautilus work with network fs since I now have a nextcloud instance
  # environment.sessionVariables.GIO_EXTRA_MODULES = "${config.services.gvfs.package}/lib/gio/modules";
  # environment.variables.GIO_EXTRA_MODULES = lib.mkForce config.environment.sessionVariables.GIO_EXTRA_MODULES;
  services.displayManager.ly.enable = true;

  services.blueman.enable = true;

  # for hyprland electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.pam.services.hyprlock = {};
  security.rtkit.enable = true;

  # to allow kdeconnect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  programs.ssh.startAgent = true;
}