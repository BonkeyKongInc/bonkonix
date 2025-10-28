local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local gitsigns = require("gitsigns")

local M = {}

-- Safe function to count lines
local function safe_count(val)
  if type(val) == "number" then return val end
  if type(val) == "table" then return #val end
  return 0
end

-- Main picker
function M.git_hunks_picker(opts)
  opts = opts or {}

  local hunks = gitsigns.get_hunks()
  if not hunks or vim.tbl_isempty(hunks) then
    vim.notify("No git hunks in this buffer", vim.log.levels.INFO)
    return
  end

  -- Build entries
  local entries = {}
  for _, hunk in ipairs(hunks) do
    table.insert(entries, {
      value = {
        start = hunk.start,
        finish = hunk.finish,
        type = hunk.type,
        head = hunk.head,
      },
      display = string.format(
        "[%s] %d:%d %s",
        hunk.type,
        safe_count(hunk.added),
        safe_count(hunk.removed),
        hunk.head or ""
      ),
      ordinal = hunk.head or "",
    })
  end

  -- Telescope picker
  pickers.new(opts, {
    prompt_title = "Git Hunks",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return entry
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry)
        local val = entry.value
        if not val or not val.start or not val.finish then return end

        local start_line = val.start - 1
        local end_line = val.finish

        -- Get lines safely
        local ok, lines = pcall(vim.api.nvim_buf_get_lines, 0, start_line, end_line, false)
        if not ok then return end

        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

        -- Clear old highlights
        vim.api.nvim_buf_clear_namespace(self.state.bufnr, -1, 0, -1)

        -- Highlight added/removed lines
        for i, line in ipairs(lines) do
          if line:match("^%+") then
            vim.api.nvim_buf_add_highlight(self.state.bufnr, -1, "DiffAdd", i - 1, 0, -1)
          elseif line:match("^-") then
            vim.api.nvim_buf_add_highlight(self.state.bufnr, -1, "DiffDelete", i - 1, 0, -1)
          end
        end
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      local function jump_to_hunk()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection and selection.value and selection.value.start then
          vim.api.nvim_win_set_cursor(0, { selection.value.start, 0 })
        end
      end

      local function stage_hunk()
        local selection = action_state.get_selected_entry()
        if selection and selection.value then
          gitsigns.stage_hunk({ range = { selection.value.start, selection.value.finish } })
        end
      end

      local function reset_hunk()
        local selection = action_state.get_selected_entry()
        if selection and selection.value then
          gitsigns.reset_hunk({ range = { selection.value.start, selection.value.finish } })
        end
      end

      map("i", "<CR>", jump_to_hunk)
      map("n", "<CR>", jump_to_hunk)
      map("i", "<C-s>", stage_hunk)
      map("n", "<C-s>", stage_hunk)
      map("i", "<C-r>", reset_hunk)
      map("n", "<C-r>", reset_hunk)
      return true
    end,
  }):find()
end

return M

