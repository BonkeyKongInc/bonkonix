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

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)

-- keymaps for qwerty
--keymap("", "<leader>fd", "<cmd>FZF <cr>", opts)
--
-- Telescope
local live_grep_args = require("telescope").extensions.live_grep_args 
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
local telescope_bonky = require("user.telescope_bonky")
--keymap.set("n", "<leader>fs", live_grep_args_shortcuts.grep_word_under_cursor)
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


--keymap("n", "<leader>fs", "<cmd>lua require('telescope').extensions.live_grep_args.shortcuts.grep_word_under_cursor()<cr>", opts)
keymap("n", "<leader>fs", "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>", opts)
 
--keymap("n", "<leader>fs", live_grep_args.shortcuts.grep_word_under_cursor())
--keymap("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>jq", "<cmd>Telescope quickfix<cr>", opts)
keymap("n", "<leader>sj", "<cmd>Telescope search_history<cr>", opts)
keymap("n", "<leader>sr", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "<leader>fe", "<cmd>Telescope changed_files<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope changed_files choose_base_branch<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>kk", "<cmd>Telescope keymaps<cr>", opts)
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
--keymap("n", "<leader>a", function() nvim_tree_api.tree.toggle({ path = "<args>", find_file = false, update_root = false, focus = true, }) end, opts('some desc'))
-- keymaps for colemak
--keymap("", "<leader>ts", "<cmd>FZF <cr>", opts)
--keymap("n", "<leader>ta", "<cmd>Telescope live_grep<cr>", opts)
--keymap("n", "<leader>tr", "<cmd>Telescope grep_string<cr>", opts)
--keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
--keymap("n", "<leader>t", ":tabnew",opts)
keymap("n", "<leader>t", "<cmd>ClangdSwitchSourceHeader<cr>", opts) 
keymap("n", "<C-p>", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "s", "<cmd>Pounce<cr>",opts)
keymap("n", "[c", "<cmd>Gitsigns next_hunk<cr>", opts) 
keymap("n", "]c", "<cmd>Gitsigns prev_hunk<cr>", opts) 
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", opts) 
keymap("n", "<leader>gb", "<cmd>Git blame<cr>", opts) 
keymap("n", "<leader>gl", "<cmd>Gitsigns blame_line<cr>", opts) 

keymap("n", "<leader>fq", ":bp|bd # <cr>", opts)
keymap("n", "<leader>il", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>", opts)

keymap("n", "<leader>re", ":Regedit ", opts)
keymap("n", "<leader>reo", ":Regedit open<cr>", opts)
--keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
--keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
