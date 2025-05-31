{ pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = ./wallpapers/nord_mountains.png;
    cursor = {
      package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
    };
    opacity = {
      applications = 0.75;
      terminal = 0.75;
    };
  };
}
