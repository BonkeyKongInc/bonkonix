require('lint').linters_by_ft = {
  python = {'flake8'},
}

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local buf = args.buf
    local win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      return -- floating window
    end
    if vim.bo[buf].buftype ~= "" then
      return -- special buffer
    end

    -- Only run once per buffer
    if vim.b[buf].entered_once then
      return
    end
    vim.b[buf].entered_once = true

    -- Your logic for normal file buffers
    require("lint").try_lint()
    print("running lint")
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
