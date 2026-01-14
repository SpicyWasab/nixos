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
    extraLuaConfig = ''
      vim.lsp.enable("tinymist")

      vim.lsp.config["tinymist"] = {

        cmd = { "tinymist" },

        filetypes = { "typst" },

        settings = {

          exportPdf = "onSave"

        }

      }

      vim.api.nvim_create_user_command("OpenPdf", function()

        local filepath = vim.api.nvim_buf_get_name(0)

        if filepath:match("%.typ$") then

          local pdf_path = filepath:gsub("%.typ$", ".pdf")

          vim.system({ "open", pdf_path })

        end

      end, {})
    '';
    plugins = [
      {
        plugin = pkgs.vimPlugins.ultisnips;
        config = ''
          let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
          let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
          let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops
        '';
      }
      {
        plugin = pkgs.vimPlugins.typst-vim;
      }
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
      }
      {
        plugin = pkgs.vimPlugins.typst-preview-nvim;
      }
    ];
  };

  # git (took me a while)
  programs.git = {
    enable = true;
    userName  = "Wasab'";
    userEmail = "spicywasab+github@proton.me";
  };
}
