-- Make ALL deletes and yanks rotate numbered registers
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local ev = vim.v.event
    -- Skip operator-pending or visual selections that aren't deletions/yanks
    if not (ev.operator == "d" or ev.operator == "y") then return end

    -- Skip single-character deletes (x, X)
    local lines = ev.regcontents
    if #lines == 1 and #lines[1] == 1 then return end
    -- Shift numbered registers 9→8→...→1
    for i = 9, 2, -1 do
      vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
    end

    -- Copy current unnamed register into "1
    local content = vim.fn.getreg('"')
    local regtype = vim.fn.getregtype('"')
    vim.fn.setreg("1", content, regtype)
  end,
})
