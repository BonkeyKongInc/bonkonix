{ pkgs, darkmode, config, ... }:
  let
  pounce = pkgs.vimUtils.buildVimPlugin {
    name = "pounce";
    src = pkgs.fetchFromGitHub {
      owner = "rlane";
      repo = "pounce.nvim";
      rev = "0c044cad69571d57d8f64a41cca95332859b6abc";
      hash = "sha256-ixzknnWkCJ+DhooYv7QeVou4ur0/bump3cWgD3O3wV0=";
    };
  };
  moonfly = pkgs.vimUtils.buildVimPlugin {
    name = "moonfly";
    src = pkgs.fetchFromGitHub {
      owner = "bluz71";
      repo = "vim-moonfly-colors";
      rev = "d43001d901599ba7273dc5700db26948ffc0bac6";
      hash = "sha256-fNBpmc/y8Okv+y/ho1bL6PIiHdG47HfuvdVnuU1WtlU=";
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
        pounce
        telescope-nvim
        telescope-live-grep-args-nvim
        neoscroll-nvim
        #key-menu - not found
        #editorconfig - not found
        gitsigns-nvim
        #telescope-changed-files - not found
        fzf-vim
        nvim-web-devicons
        moonfly

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
