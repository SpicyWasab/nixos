{ pkgs, ... }:

{
  # my favorite shell
  # (because i'm too lazy and don't have time to get into zsh for now)
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -g editor nvim

      alias ls="eza"
      alias config="cd ~/.config/nixos"

      function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      end
    '';
    plugins = [
    	# my favorite prompt
	{ name = "tide" ; src = pkgs.fishPlugins.tide.src; }
    ];
    
  };
  
  # neovim !
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
      set autoindent expandtab tabstop=2 shiftwidth=2
    '';
  };

  # git (took me a while)
  programs.git = {
    enable = true;
    userName  = "Wasab'";
    userEmail = "spicywasab+github@proton.me";
  };
}
