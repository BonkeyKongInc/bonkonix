{ pkgs, darkmode, config, ... }:
  let
  bolt = pkgs.vimUtils.buildVimPlugin {
    name = "bolt";
    src = pkgs.fetchFromGitHub {
      owner = "ripxorip";
      repo = "bolt.nvim";
      rev = "aecf421d9916c2480bd2bd1f86560634379cc671";
      hash = "sha256-z7/3+/WMlJGQf8VzGgPTpjydFbQsDdCm6IftnZ0K6k4=";
    };
  };
  in 
  {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        packer-nvim
        popup-nvim
        plenary-nvim
        lualine-nvim
        nightfox-nvim
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp_luasnip
        cmp-nvim-lsp
        cmp-nvim-lua
        luasnip
        nvim-lspconfig
        #lsp installer - not found
        #pounce - not found
        telescope-nvim
        neoscroll-nvim
        #key-menu - not found
        #editorconfig - not found
        gitsigns-nvim
        #telescope-changed-files - not found
        fzf-vim
        nvim-web-devicons

        #----- ripxorip plugins -----
        #bolt
        #nvim-lspconfig
        #gitsigns-nvim
        #catppuccin-nvim
        #nvim-compe
        #vim-fugitive
        #suda-vim
        #nvim-autopairs
        #vim-ripgrep
        #github-nvim-theme
        # FIXME These shall be created by me
        #vim-ripgrep
        #ripxorip/aerojump
        #ripxorip/utils
        #editorconfig-vim
        #neoformat
        #lsp_signature-nvim
        #vim-vsnip
        #nvim-treesitter.withAllGrammars
        #playground
        #fzf-vim
        #vim-tmux-navigator
        #vim-unimpaired
      ];

      extraPackages = with pkgs; [
        tree-sitter
      ];

      extraConfig = ''
        :luafile ~/.config/nvim/init.lua
      '';
    };


    home = {
      file = {
        #"${config.xdg.configHome}/nvim/lua/config/colorscheme.lua".text = "${nvim_colorscheme}";
      };
    };

    # FIXME Continue here, by generating the colorscheme.lua file according to the darkmode variable
    # It shall be written and probably be removed from the local .config folder
    xdg.configFile.nvim = {
      source = ./config;
      recursive = true;
    };
}
