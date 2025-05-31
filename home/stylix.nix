{ pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
    };
    opacity = {
      applications = 0.6;
      terminal = 0.6;
    };
  };
}