{ config, pkgs, inputs, system, lib, ... }:

{
  imports = [
    ./packages.nix # packages
    ./wm # everything related to the WM and its tools
    ./cli.nix # shell and cli programs
    ./programs # everything else that is programs.<something>
    ./xdg.nix # mainly userDirs and portals
  ];
  
  home = {
    username = "wasab";
    homeDirectory = "/home/wasab";
    stateVersion = "25.05";
  };

  # enabling user fonts
  # fonts.fontconfig.enable = true;
  
  # let home manager install and manage itself
  programs.home-manager.enable = true;
}
