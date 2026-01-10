{ package, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # terminal browsers
    offpunk

    # hyprland-related
    hypridle
    hyprpaper
    waybar
    hyprshot

    # gui apps (gnome core)
    nautilus
    sushi
    baobab
    gnome-disk-utility
    mission-center
    decibels
    showtime
    loupe
    evince
    warp

    # slowly replacing every gui app with an alternative
    zathura # instead of evince (which was great)
    imv
    feh
    qimgv
  ];
}