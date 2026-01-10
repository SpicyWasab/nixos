{ lib, ... }:

{
  dconf.settings = {
    "/org/gnome/desktop/interface" = {
      enable-hot-corners = false;
    };

    "org/gnome/shell/extensions" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
      ];

      "org/gnome/shell/extensions/blur-my-shell/panel/blur" = false;
    };
  };
}