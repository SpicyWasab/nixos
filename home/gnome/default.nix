{ config, pkgs, inputs, system, lib, ... }:

{
  imports = [
    ../home.nix # obviously
    ./packages.nix # packages
    ./programs.nix # everything else that is programs.<something>
    # ./xdg.nix # for portals
  ];
}
