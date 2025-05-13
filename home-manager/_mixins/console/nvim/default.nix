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
  aerojump = pkgs.vimUtils.buildVimPlugin {
    name = "aerojump";
    src = pkgs.fetchFromGitHub {
      owner = "ripxorip";
      repo = "aerojump.nvim";
      rev = "d0cda41";
      hash = "sha256-VAW3lPurGAW7hcAFC6Z1sHGU1LU6kafgyNmP8AnJ6QI=";
    };
  };
  telescope-changedfiles = pkgs.vimUtils.buildVimPlugin {
    name = "telescope-changed-files";
    src = pkgs.fetchFromGitHub {
      owner = "axkirillov";
      repo = "telescope-changed-files";
      rev = "0ccf50680abba21127c46c477f4646f2c5589767";
      hash = "sha256-M5Eq1EDQQY+307VX1+yOX0fSyeOCJmnBh5fvz6Yis3s=";
    };
  };
  neo-img = pkgs.vimUtils.buildVimPlugin {
    name = "neo-img";
    src = pkgs.fetchFromGitHub {
      owner = "Skardyy";
      repo = "neo-img";
      rev = "f67a54";
      hash = "sha256-071BYXkOzimroOqesNOOhBJ54rvjDkP+EnGJ+QEAdJM=";
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
        #plenary-nvim
        lualine-nvim
        nightfox-nvim
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp_luasnip
        #cmp-nvim-lsp
        #cmp-nvim-lua
        #luasnip
        nvim-lspconfig
        #lsp installer - not found
        pounce
        telescope-nvim
        telescope-live-grep-args-nvim
        telescope-changedfiles 
        neoscroll-nvim
        gitsigns-nvim
        nvim-treesitter.withAllGrammars
        fzf-vim
        nvim-web-devicons
        moonfly
        markdown-preview-nvim
        asyncrun-vim
        vim-markdown-composer
        render-markdown-nvim
        aerojump

        markdown-preview-nvim
        asyncrun-vim
        vim-markdown-composer
        render-markdown-nvim
        vim-dirdiff
        markview-nvim
        guess-indent-nvim
      #neo-img
        vimtex

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

    # FIXME Continue here, by generating the colorscheme.lua file according to the darkmode variable
    # It shall be written and probably be removed from the local .config folder
    xdg.configFile.nvim = {
      source = ./config;
      recursive = true;
    };
}
