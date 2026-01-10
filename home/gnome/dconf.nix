{ lib, ... }:

{
  dconf.settings = {
    "org/gnome/shell/extensions" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
      ];

      "org/gnome/shell/extensions/blur-my-shell/panel/blue" = false;
    };
  };
}