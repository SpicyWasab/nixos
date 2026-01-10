{ package, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # music and homeworks mood
    amberol
    parabolic
    gnome-solanum # pomodoro timer
    # cavalier is defined in ./programs as a HM module

    # file manipulations and editing
    libreoffice
    gimp
    audacity
    vscodium
    kdePackages.kdenlive

    # zen browser (use a home-manager module later) (edit : module is broken)
    inputs.zen-browser.packages."${system}".twilight

    # tor browser (just in case)
    tor-browser

    thunderbird

    # obsidian (vive la prépa)
    obsidian

    # anki (vive la prépaaaa)
    anki

    # selfhosted !
    appflowy
    owncloud-client
    pika-backup # yay !

    # now that someone gave me a wacom tablet
    rnote
    xournalpp # apparently there's a neat obsidian plugin so let's try this

    # pas une bonne idée avec la prépa mais faut bien que je profite un peu
    heroic
    steam
    prismlauncher

    # histoire de pouvoir vloguer avec le style à la seul sur mars
    obs-studio
  ];
}
