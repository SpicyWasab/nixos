{ ... }:

{
  # just for this file to not become a mess
  imports = [
    ./waybar-config.nix
    ./waybar-style.nix
  ];
  
  # only get colors from stylix
  stylix.targets.waybar.addCss = false;

  # seems empty I know
  programs.waybar = {
    enable = true;
  };
}