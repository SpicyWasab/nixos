{ pkgs, ... }:

let themes = {
  nord = {
    scheme = "nord";
    wallpaper = ./wallpapers/nord_mountains.png;
  };
  spaceduck = {
    scheme = "spaceduck";
    # wallpaper = ./wallpapers/spaceduck.png;
    wallpaper = ./wallpapers/hang-in-there.png;
  };
  woodland = {
    scheme = "woodland";
    wallpaper = ./wallpapers/woodland.webp;
  };
};
in let theme = themes.spaceduck;
in {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme.scheme}.yaml";
    image = theme.wallpaper;
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
