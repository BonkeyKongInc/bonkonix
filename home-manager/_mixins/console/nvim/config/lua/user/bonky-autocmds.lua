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

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.acclog",
  callback = function(args)
    local file = vim.fn.fnamemodify(args.file, ":p")

    -- Look for an existing terminal buffer for this file
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      print(buf)
      if vim.api.nvim_buf_is_loaded(buf) then
        local name = vim.api.nvim_buf_get_name(buf)
          print(name)

        if name:match("^term://") and name:find(file, 1, true) then
          vim.api.nvim_set_current_buf(buf)
          return
        else
        end
      end
    end
    -- Otherwise open a new terminal
    vim.cmd("terminal cat " .. vim.fn.fnameescape(file))
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "dd", function()
      local qf = vim.fn.getqflist()
      table.remove(qf, vim.fn.line("."))
      vim.fn.setqflist(qf, "r")
    end, { buffer = true })
  end,
})
