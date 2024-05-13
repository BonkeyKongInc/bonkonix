--local colorscheme = "carbonfox"
--local colorscheme = "modus-themes.nvim"
--local colorscheme = "night-owl.nvim"
local colorscheme = "moonfly"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
