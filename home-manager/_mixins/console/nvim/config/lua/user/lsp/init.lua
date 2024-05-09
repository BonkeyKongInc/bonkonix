local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("no lsp config")
	return
end

require("nvim-lsp-installer").setup {}
require("user.lsp.handlers").setup()
--require("user.lsp.lsp-installer")
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {on_attach = on_attach}
lspconfig.pyright.setup {on_attach = on_attach}
lspconfig.lua_ls.setup {on_attach = on_attach}
--require'lspconfig'.pyright.setup{}

--require("user.lsp.lsp-installer")
--require("user.lsp.handlers").setup()
