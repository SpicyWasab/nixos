{ config, pkgs, inputs, system, lib, ... }:

{
  imports = [
    ../home.nix # obviously
    ./packages.nix # packages
    ./programs.nix # everything else that is programs.<something>
    ./extensions.nix # gnome extensions
    ./dconf.nix
    # ./xdg.nix # for portals
  ];
}
