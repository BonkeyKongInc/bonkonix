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

  regedit  = pkgs.vimUtils.buildVimPlugin {
    name = "jmattaa";
    src = pkgs.fetchFromGitHub {
      owner = "jmattaa";
      repo = "regedit.vim";
      rev = "e211d89";
      hash = "sha256-yCb3QZy2Np/hllpwObsbfr8QxyYC4OF7TujmBce5c54=";
    };
  };

  dir-telescope  = pkgs.vimUtils.buildVimPlugin {
    name = "dir-telescope";
    src = pkgs.fetchFromGitHub {
      owner = "princejoogie";
      repo = "dir-telescope.nvim";
      rev = "805405b9f98dc3470f8676773dc0e6151a9158ed";
      hash = "sha256-B/cZUkjAVi52jopBwZJYmiaVf8PqnawusnSGOx7dDqs=";
    };
    # Fixes that telescope isnt found in build tests
    doCheck = false;
  };
  nvim-tree-preview = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-tree-preview";
    src = pkgs.fetchFromGitHub {
      owner = "b0o";
      repo = "nvim-tree-preview.lua";
      rev = "e763de51dca15d65ce4a0b9eca716136ac51b55c";
      hash = "sha256-7XPYnset01YEtwPUEcS+cXZQwf8h9cARKlgwwCUT3YY=";
    };
    doCheck = false;
  };
  telescope-gitsigns= pkgs.vimUtils.buildVimPlugin {
    name = "telescope-gitsigns";
    src = pkgs.fetchFromGitHub {
      owner = "radyz";
      repo = "telescope-gitsigns";
      rev = "e568da4b8b6da800bd9274f7b509c0da81fc8615";
      hash = "sha256-ULmo84ameJ4D62wrvsb+9YCUKGhOYpHvgIffGKF0Vo8=";
    };
    doCheck = false;
  };
  in 
  {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        #packer-nvim
        popup-nvim
        #plenary-nvim
        lualine-nvim
        nightfox-nvim
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp_luasnip
        cmp-nvim-lsp
        luasnip
        nvim-lspconfig
        pounce
        telescope-nvim
        telescope-live-grep-args-nvim
        telescope-changedfiles 
        dir-telescope
        telescope-gitsigns
        neoscroll-nvim
        gitsigns-nvim
        nvim-tree-lua
        nvim-treesitter.withAllGrammars
        nvim-tree-preview
        image-nvim
        fzf-vim
        nvim-web-devicons
        moonfly
        markdown-preview-nvim
        asyncrun-vim
        vim-markdown-composer
        render-markdown-nvim
        markdown-preview-nvim
        asyncrun-vim
        vim-markdown-composer
        render-markdown-nvim
        vim-dirdiff
        markview-nvim
        guess-indent-nvim
      #neo-img
        vimtex
        regedit
        registers-nvim
        ultimate-autopair-nvim
        hardtime-nvim
      ];

      extraPackages = with pkgs; [
        tree-sitter
        nil
        lua-language-server
        pyright
        python312Packages.jedi
        bash-language-server
        shellcheck
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
