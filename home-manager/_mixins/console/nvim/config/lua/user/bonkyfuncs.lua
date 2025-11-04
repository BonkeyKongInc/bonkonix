
local M = {}

local function matching(open)
  local pairs = { ['(']=')', ['[']=']', ['{']='}', ['"']='"', ["'"]="'" }
  return pairs[open] or open
end

function M.WrapVisual()
  local symbol = vim.fn.input('Enter surround symbol (", (, [, {, ): ')
  if not symbol or symbol == "" then return end

  -- Exit visual mode
  local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "n", false)

  -- Get selection positions
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]

  -- Get lines of selection
  local lines = vim.api.nvim_buf_get_lines(0, start_line-1, end_line, false)

  local s_col = 1
  local bufnr = start_pos[1]
  local timeout = 5000
  local ns = vim.api.nvim_create_namespace("wrap_visual_highlight")
  for i, line in ipairs(lines) do
    -- wrap only the selected part
    lines[i] = line:sub(1, start_col-1) .. symbol .. line:sub(start_col, end_col) .. matching(symbol) .. line:sub(end_col+1)

    local line_nr = start_line - 1 + (i - 1)
    vim.schedule(function()
      vim.api.nvim_buf_add_highlight(bufnr, ns, 'Question', line_nr, start_col - 1, start_col)
      vim.api.nvim_buf_add_highlight(bufnr, ns, 'Question', line_nr, end_col + 1, end_col + 2)
    end)
  end
  vim.api.nvim_buf_set_lines(0, start_line-1, end_line, false, lines)
  vim.schedule(function()
    vim.api.nvim_win_set_cursor(0, {end_line, start_col})
  end)
  vim.defer_fn(function()
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  end, 1000)
end

return M
