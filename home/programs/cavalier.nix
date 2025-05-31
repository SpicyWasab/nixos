{ config, ... }:

{
  programs.cavalier = {
    enable = true;
    settings.general = {
      AutohideHeader = true;
      Mode = 1;
    };
  };
}