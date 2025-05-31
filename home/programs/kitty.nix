{ ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 1; # j'allais le désactiver mais ça vient de me sauver
      # background_opacity = "0.5";
      background_blur = "5";
    };
  };
}