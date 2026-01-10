{ config, pkgs, inputs, system, lib, ... }:

{
  imports = [
    ./packages.nix
    ./cli.nix # shell and cli programs
    ./xdg.nix # for userDirs
    ./gui-common.nix # don't forget to add this as I just did...
  ];

  home = {
    username = "wasab";
    homeDirectory = "/home/wasab";
    stateVersion = "25.05";
  };
  
  # let home manager install and manage itself
  programs.home-manager.enable = true;
}
