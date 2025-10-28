local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

--telescope.load_extension('media_files')

local builtin = require("telescope.builtin")
local actions = require "telescope.actions"
local lga_actions = require("telescope-live-grep-args.actions")
local utils = require("telescope.utils")
--local dir_telescope = require("dir-telescope")

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["v"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    find_files = {
          mappings = {
            i = {
              ["<C-h>"] = function(prompt_bufnr)
                local selection = require("telescope.actions.state").get_selected_entry()
                local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                require("telescope.actions").close(prompt_bufnr)
                -- Depending on what you want put `cd`, `lcd`, `tcd`
                vim.cmd(string.format("silent lcd %s", dir))
              end
            }
          }
        },
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = {"png", "webp", "jpg", "jpeg"},
        find_cmd = "fzf" -- find command (defaults to `fd`)
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-i>"] = lga_actions.quote_prompt({ postfix =  " " .. vim.fn.expand('%:p:h')}),
          ["<C-f>"] = lga_actions.quote_prompt({ postfix =  " " .. "--type "}),
          ["<C-d>"] = lga_actions.quote_prompt({ postfix = " --iglob  **/*/**" }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
--    dir_telescope = {
--      mappings = {
--        i = {
--            ["<C-h>"] = function(prompt_bufnr)
--              local selection = require("telescope.actions.state").get_selected_entry()
--              local dir = vim.fn.fnamemodify(selection.path, ":p:h")
--              require("telescope.actions").close(prompt_bufnr)
--              -- Depending on what you want put `cd`, `lcd`, `tcd`
--              vim.cmd(string.format("silent lcd %s", dir))
--            end
--            }
--
--      },
--      hidden = true,
--      no_ignore = false,
--      show_preview = true,
--      follow_symlinks = false,
--    }
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}
--leader>ff"] = { function() builtin.find_files({ cwd = utils.buffer_dir() }) end, desc = "Find files in cwd" }
--telescope.configs = {}
--telescope.configs["telescope-file-browser.nvim"] = function()
telescope.load_extension("live_grep_args")
--telescope.load_extension("dir")
require('telescope').load_extension('changed_files')
require("telescope").load_extension("git_signs")
--require("telescope").load_extension "file_browser"
--end
