local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {}
-- persistent state
local dir = require('dir-telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- persistent state
local state = {
  cwd = vim.loop.cwd(),
  hidden = false,
}

M.interactive_dir_telescope = function (opts)
  opts = opts or {}
  opts.cwd = opts.cwd or state.cwd
  opts.hidden = opts.hidden or state.hidden

  local prompt_title = string.format(
    "Dir [%s] (%s)",
    opts.hidden and "hidden:on" or "hidden:off",
    opts.cwd
  )

  require("telescope").extensions.dir.find_files(vim.tbl_extend("force", opts, {
    prompt_title = prompt_title,
    attach_mappings = function(prompt_bufnr, map)
      local function refresh_picker(new_opts)
        actions.close(prompt_bufnr)
        if new_opts.hidden ~= nil then state.hidden = new_opts.hidden end
        if new_opts.cwd ~= nil then state.cwd = new_opts.cwd end
        interactive_dir_telescope(vim.tbl_extend("force", opts, new_opts))
      end

      -- toggle hidden files
      map('i', '<C-h>', function()
        refresh_picker({ hidden = not opts.hidden })
      end)
      map('n', '<C-h>', function()
        refresh_picker({ hidden = not opts.hidden })
      end)

      return true
    end,
  }))
end

return M
