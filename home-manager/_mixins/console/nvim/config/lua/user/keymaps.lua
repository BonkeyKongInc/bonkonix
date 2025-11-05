local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   insert_mode = "i",
  --   normal_mode = "n",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Tab navigation
keymap("n", "<A-h>", "gt", opts)
keymap("n", "<A-l>", "gT", opts)
-- Resize with arrows

keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-------------------------Telescope------------------------- 
local telescope_bonky = require("user.telescope_bonky")
keymap("n", "<leader>fd", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fa", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", opts)
keymap("n", "<leader>tt", "<cmd>Telescope<cr>", opts)
keymap("n", "<leader>fad",
  "<cmd>lua require('telescope.builtin').live_grep({ search_dirs = { vim.fn.expand('%:p:h') }, prompt_title = 'Find in ' .. vim.fn.expand('%:p:h') })<cr>",
  opts
)
keymap("n", "<leader>fh", ":<cmd>lua require('telescope').extensions.git_signs.git_signs({initial_mode=\"normal\",})<cr>", opts)
vim.keymap.set('n', '<leader>ff', function()
  telescope_bonky.interactive_dir_telescope()
end, { noremap = true, silent = true, desc = "Find files (interactive, stateful)" })
keymap("n", "<leader>fs", "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>", opts)
keymap("n", "<leader>jq", "<cmd>Telescope quickfix<cr>", opts)
keymap("n", "<leader>sj", "<cmd>Telescope search_history<cr>", opts)
keymap("n", "<leader>sr", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "<leader>fe", "<cmd>Telescope changed_files<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope changed_files choose_base_branch<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>kk", "<cmd>Telescope keymaps<cr>", opts)
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>t", "<cmd>ClangdSwitchSourceHeader<cr>", opts) 
keymap("n", "<C-p>", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "s", "<cmd>Pounce<cr>",opts)

-----------------------GIT-----------------------
keymap("n", "[c", "<cmd>Gitsigns next_hunk<cr>", opts) 
keymap("n", "]c", "<cmd>Gitsigns prev_hunk<cr>", opts) 
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", opts) 
keymap("n", "<leader>gb", "<cmd>Git blame<cr>", opts) 
keymap("n", "<leader>gl", "<cmd>Gitsigns blame_line<cr>", opts) 

-----------------------MISC-----------------------
--- close only buffer container
keymap("n", "<leader>fq", ":bp|bd # <cr>", opts)
--- my own surround func
keymap("x", "<leader>s", ":<cmd>lua require('user.bonkyfuncs').WrapVisual()<cr>", opts)

keymap("n", "<leader>il", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>", opts)
keymap("n", "<leader>re", ":Regedit ", opts)
keymap("n", "<leader>reo", ":Regedit open<cr>", opts)
