{ config, pkgs, inputs, system, lib, ... }:

{
  imports = [
    ../home.nix # obviously
    ./packages.nix # packages
    ./wm # everything related to the WM and its tools
    ./programs.nix # everything else that is programs.<something>
    ./xdg.nix # for portals
  ];
}
