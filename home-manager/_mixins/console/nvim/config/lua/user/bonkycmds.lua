
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

  for i, line in ipairs(lines) do
    local s_col = 1
    local e_col = #line
    if i == 1 then s_col = start_col end
    if i == #lines then e_col = end_col end
    -- wrap only the selected part
    lines[i] = line:sub(1, s_col-1) .. symbol .. line:sub(s_col, e_col) .. matching(symbol) .. line:sub(e_col+1)
  end

  vim.api.nvim_buf_set_lines(0, start_line-1, end_line, false, lines)
end

return M
