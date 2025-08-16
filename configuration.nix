# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    plymouth = {
      enable = true;
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;  
  };

  networking.hostName = "wasab-slg2-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wasab = {
    isNormalUser = true;
    description = "Wasab";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish; # (a reconsiderer)
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # flakes baby !
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #   kitty
     brightnessctl
     playerctl
     powertop
     # evince
     # obsidian
     # baobab
     # gnome-disk-utility
     # sushi
     # decibels
     # loupe
     # inputs.zen-browser.packages."${system}".twilight # I should definitely move this later with home manager when I'll figure it out
     # ocamlPackages.utop # vive la MP2I
  ];

  # WASAB
 
  # xdg.userDirs = {
  #    enable = true;
  #    createDirectories = true;
  # };

  programs.hyprland.enable = true;

  # programs.wofi.enable = true;

  # fonts.packages = with pkgs; [
  #   font-awesome
  # ];

  programs.fish.enable = true; # cannot put this in home manager

  # programs.firefox.enable = true; # now using zen browser
  services.gvfs.enable = true; # required for nautilus
  services.gnome.glib-networking.enable = true;
  programs.dconf.enable = true; # trying really hard to make nautilus work with network fs since I now have a nextcloud instance
  # environment.sessionVariables.GIO_EXTRA_MODULES = "${config.services.gvfs.package}/lib/gio/modules";
  # environment.variables.GIO_EXTRA_MODULES = lib.mkForce config.environment.sessionVariables.GIO_EXTRA_MODULES;

  services.displayManager.ly.enable = true;

  
  services.power-profiles-daemon.enable = true;

  # services.tlp.enable = true; # for battery life
  powerManagement.powertop.enable = true;
  
  services.thermald.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # for hyprland electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  # because this was annoying (et comme ça je suis sûr de pas éteindre mon ordi accidentellement en cours...
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=suspend
    HandleLidSwitch=suspend
    # LidSwitchIgnoreInhibited=yes
  '';
  
  security.pam.services.hyprlock = {};
  security.rtkit.enable = true;

  # to allow kdeconnect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  # for stylix to work, somehow
  # stylix.image = null;

  programs.ssh.startAgent = true;

  # for heroic to work
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # programs.missionCenter.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "24.11"; # Did you read the comment?

}
