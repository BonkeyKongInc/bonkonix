local fn = vim.fn

return require('packer').startup(function()

  -- My plugins here
  use {'wbthomason/packer.nvim', opt = true}
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "nvim-tree/nvim-web-devicons" -- Useful lua functions used ny lots of plugins
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }
  use 'nvim-lualine/lualine.nvim'
  use 'tpope/vim-fugitive'
  -- Markdown preview
  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use({
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    -- requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
     requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({})
    end,
})
  --use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install', cmd = 'MarkdownPreview'}

  -- Color scheme
	--use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "EdenEast/nightfox.nvim" -- Packer
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  --use "hrsh7th/cmp-nvim-lua"

  --use 'm4xshen/autoclose.nvim'
  --use {
  --  "windwp/nvim-autopairs",
  --    config = function() require("nvim-autopairs").setup {} end
  --}
  -- snippets
  --use "L3MON4D3/LuaSnip" --snippet engine
  --use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
	
  -- LSP
  --use "neovim/nvim-lspconfig" -- enable LSP
  --use "williamboman/nvim-lsp-installer" -- simple to use language server installer

  use "rlane/pounce.nvim"
  use "ripxorip/aerojump.nvim"
  -- Telescope
  use "nvim-telescope/telescope.nvim"
	use { "axkirillov/telescope-changed-files" }
  -- Startup screen
  use {
    "startup-nvim/startup.nvim",
    requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    config = function()
      require"startup".setup()
    end
  }

  -- Neoscroll
  use 'karb94/neoscroll.nvim'
  -- Command map finder
  --use 'linty-org/key-menu.nvim'
  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
	-- Editor for to use local tab settings etc
	use 'gpanders/editorconfig.nvim'
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  --if PACKER_BOOTSTRAP then
  --  require("packer").sync()
  --end
  use { "junegunn/fzf", run = ":call fzf#install()" }
	--use 'peterhoeg/vim-qml'

  -- git
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use { 'Skardyy/neo-img',
    build = function()
      require('neo-img').install()
    end,
    config = function()
      require('neo-img').setup()
    end
  }

  use { 'nmac427/guess-indent.nvim',
    config = function() 
      require('guess-indent').setup {} 
    end,
  }

end)
